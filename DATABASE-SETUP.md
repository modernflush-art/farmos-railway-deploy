# PostgreSQL Database Setup Guide

This guide explains how to use the PostgreSQL database integration with your FarmOS project.

## Quick Start

1. **Copy the environment file:**
   ```bash
   cp .env.example .env
   ```

2. **Edit the .env file with your passwords:**
   ```bash
   # Edit .env file and set secure passwords
   nano .env
   ```

3. **Start the services:**
   ```bash
   docker-compose up -d
   ```

4. **Test the database connection:**
   ```bash
   php scripts/test-db-connection.php
   ```

## What's Included

### Database Services

- **PostgreSQL 15**: Main database server
- **pgAdmin**: Web-based database administration tool
- **FarmOS**: Connected to PostgreSQL automatically

### Access Points

- **FarmOS Application**: http://localhost
- **pgAdmin**: http://localhost:8080
  - Email: admin@farmos.local
  - Password: (set in .env file)
- **PostgreSQL Direct**: localhost:5432

### Database Configuration

The PostgreSQL setup includes:

- **Optimized configuration** for FarmOS performance
- **Automatic initialization** with required extensions
- **Backup/restore scripts** for data management
- **Read-only user** for reporting and backups

## Database Management

### Connection Testing

Test your database connection:
```bash
php scripts/test-db-connection.php
```

### Creating Backups

Create a database backup:
```bash
./scripts/backup-database.sh
```

Backups are stored in the `./backups/` directory and automatically compressed.

### Restoring Backups

Restore from a backup file:
```bash
./scripts/restore-database.sh ./backups/farmos_backup_20241201_120000.sql.gz
```

### Direct Database Access

Connect directly to PostgreSQL:
```bash
docker-compose exec postgres psql -U postgres -d farmos
```

## Environment Variables

Required environment variables in `.env`:

```bash
# PostgreSQL Database
POSTGRES_PASSWORD=your_secure_password_here
PGADMIN_PASSWORD=your_pgadmin_password_here

# Optional: FarmOS Configuration
FARMOS_ADMIN_EMAIL=admin@farmos.local
FARMOS_ADMIN_PASSWORD=your_farmos_password

# Optional: Database initialization
POSTGRES_INITDB_ARGS=--encoding=UTF-8 --lc-collate=C --lc-ctype=C
```

## Database Schema

The PostgreSQL database includes these key features:

- **Primary database**: `farmos` (main application data)
- **Extensions enabled**:
  - `pg_trgm` (trigram matching for text search)
  - `unaccent` (text search without accents)
  - `uuid-ossp` (UUID generation)
- **Read-only user**: `farmos_readonly` (for reports/backups)

## Performance Optimizations

The database includes optimized settings for:

- **Memory allocation** (shared_buffers, work_mem)
- **Write-ahead logging** (WAL configuration)
- **Query planning** (effective_cache_size)
- **Auto-vacuum** (automatic maintenance)

## Monitoring

### pgAdmin Features

Access pgAdmin at http://localhost:8080 to:

- View database structure and data
- Run SQL queries
- Monitor performance
- Manage users and permissions
- View logs and statistics

### Log Files

PostgreSQL logs are available via Docker:
```bash
docker-compose logs postgres
```

## Development Workflow

### For Development

1. **Start services**: `docker-compose up -d`
2. **Access FarmOS**: http://localhost
3. **Admin panel**: http://localhost:8080
4. **Test changes**: `php scripts/test-db-connection.php`

### For Production

1. **Use secure passwords** in production .env
2. **Regular backups**: Set up cron job for `./scripts/backup-database.sh`
3. **Monitor performance**: Use pgAdmin for database monitoring
4. **Update regularly**: Keep PostgreSQL and FarmOS images updated

## Troubleshooting

### Common Issues

**Connection refused:**
- Check if containers are running: `docker-compose ps`
- Wait for PostgreSQL to fully start (30-60 seconds)
- Verify .env file exists and has correct passwords

**Permission denied:**
- Check file permissions: `ls -la database/`
- Ensure docker has access to bind mount directories

**Performance issues:**
- Increase memory settings in `database/postgresql.conf`
- Monitor with pgAdmin performance dashboard
- Check disk space for database volume

### Useful Commands

```bash
# View running containers
docker-compose ps

# View logs
docker-compose logs postgres
docker-compose logs farmos

# Restart services
docker-compose restart

# Stop all services
docker-compose down

# Remove all data (⚠️ destructive)
docker-compose down -v
```

## Security Notes

- **Change default passwords** before production use
- **Use strong passwords** (20+ characters, mixed case, numbers, symbols)
- **Limit network access** to PostgreSQL port in production
- **Regular updates** of container images
- **Regular backups** stored securely off-site

## Support

For FarmOS-specific database issues, refer to:
- [FarmOS Documentation](https://farmos.org/guide/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
