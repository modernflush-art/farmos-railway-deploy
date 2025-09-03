#!/bin/bash

# PostgreSQL Database Backup Script
# This script creates a backup of your FarmOS database

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

# Create backup directory
BACKUP_DIR="./backups"
mkdir -p $BACKUP_DIR

# Generate backup filename with timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/farmos_backup_$TIMESTAMP.sql"

echo "Creating PostgreSQL database backup..."
echo "======================================"
echo "Host: $DB_HOST"
echo "Port: $DB_PORT"
echo "Database: $DB_NAME"
echo "User: $DB_USER"
echo "Backup file: $BACKUP_FILE"
echo "======================================"

# Create the backup using docker exec
if docker-compose ps postgres | grep -q "Up"; then
    echo "Creating backup via Docker container..."
    docker-compose exec -T postgres pg_dump \
        -h localhost \
        -p 5432 \
        -U $DB_USER \
        -d $DB_NAME \
        --no-password \
        --verbose \
        --clean \
        --no-acl \
        --no-owner > $BACKUP_FILE

    if [ $? -eq 0 ]; then
        echo "✅ Backup created successfully: $BACKUP_FILE"
        echo "Backup size: $(du -h $BACKUP_FILE | cut -f1)"
        
        # Compress the backup
        gzip $BACKUP_FILE
        echo "✅ Backup compressed: $BACKUP_FILE.gz"
        echo "Compressed size: $(du -h $BACKUP_FILE.gz | cut -f1)"
    else
        echo "❌ Backup failed"
        exit 1
    fi
else
    echo "❌ PostgreSQL container is not running"
    echo "Start it with: docker-compose up -d"
    exit 1
fi
