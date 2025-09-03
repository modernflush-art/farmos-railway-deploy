#!/bin/bash

# PostgreSQL Database Restore Script
# This script restores a backup to your FarmOS database

if [ $# -eq 0 ]; then
    echo "Usage: $0 <backup_file>"
    echo "Example: $0 ./backups/farmos_backup_20241201_120000.sql.gz"
    exit 1
fi

BACKUP_FILE=$1

if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Backup file not found: $BACKUP_FILE"
    exit 1
fi

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | sed 's/#.*//g' | xargs)
fi

# Set default values
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-farmos}
DB_USER=${DB_USER:-postgres}
DB_PASSWORD=${DB_PASSWORD:-$POSTGRES_PASSWORD}

echo "Restoring PostgreSQL database backup..."
echo "======================================="
echo "Host: $DB_HOST"
echo "Port: $DB_PORT"
echo "Database: $DB_NAME"
echo "User: $DB_USER"
echo "Backup file: $BACKUP_FILE"
echo "======================================="

# Check if PostgreSQL container is running
if ! docker-compose ps postgres | grep -q "Up"; then
    echo "❌ PostgreSQL container is not running"
    echo "Start it with: docker-compose up -d"
    exit 1
fi

# Ask for confirmation
read -p "⚠️  This will replace all data in the '$DB_NAME' database. Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Restore cancelled."
    exit 0
fi

# Decompress if needed
if [[ $BACKUP_FILE == *.gz ]]; then
    echo "Decompressing backup file..."
    gunzip -c $BACKUP_FILE | docker-compose exec -T postgres psql \
        -h localhost \
        -p 5432 \
        -U $DB_USER \
        -d $DB_NAME \
        --no-password
else
    echo "Restoring backup file..."
    cat $BACKUP_FILE | docker-compose exec -T postgres psql \
        -h localhost \
        -p 5432 \
        -U $DB_USER \
        -d $DB_NAME \
        --no-password
fi

if [ $? -eq 0 ]; then
    echo "✅ Database restored successfully from: $BACKUP_FILE"
else
    echo "❌ Restore failed"
    exit 1
fi
