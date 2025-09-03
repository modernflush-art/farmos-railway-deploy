# farmOS Railway Deployment Guide

This guide will help you deploy farmOS on Railway.

## Prerequisites

1. Railway account (sign up at https://railway.app)
2. GitHub account
3. Git installed locally

## Deployment Steps

### 1. Prepare Your Repository

1. Push this project to GitHub
2. Make sure all configuration files are committed:
   - `Dockerfile`
   - `php.ini`
   - `railway.json`
   - `docker-compose.yml` (for local testing)

### 2. Deploy on Railway

1. Go to https://railway.app
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose your farmOS repository
5. Railway will automatically detect the Dockerfile and start building

### 3. Add PostgreSQL Database

1. In your Railway project dashboard, click "New Service"
2. Select "Database" → "PostgreSQL"
3. Railway will create a PostgreSQL instance
4. Note the connection details (automatically available as environment variables)

### 4. Configure Environment Variables

Railway will automatically provide these database environment variables:
- `PGHOST` (use as DB_HOST)
- `PGPORT` (use as DB_PORT)
- `PGDATABASE` (use as DB_NAME)
- `PGUSER` (use as DB_USER)
- `PGPASSWORD` (use as DB_PASSWORD)

### 5. Enable PostgreSQL Extension

After deployment:
1. Go to your PostgreSQL service in Railway
2. Open the "Query" tab
3. Run: `CREATE EXTENSION pg_trgm;`

### 6. Complete farmOS Installation

1. Visit your Railway app URL
2. Follow the farmOS installation wizard
3. Use the PostgreSQL connection details from Railway

## File Upload Configuration

After installation, add this to `sites/default/settings.php`:

```php
$settings['file_private_path'] = '/opt/drupal/web/sites/default/private/files';
```

## Cron Configuration

Railway doesn't support traditional cron jobs, but you can:
1. Use the web-based cron URL method
2. Set up an external service (like cron-job.org) to hit your cron URL weekly

## Troubleshooting

- Check Railway logs for deployment issues
- Ensure all required PHP extensions are available
- Verify database connection settings
- Check file permissions for uploads
