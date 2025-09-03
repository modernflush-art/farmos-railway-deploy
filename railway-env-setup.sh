#!/bin/bash

# Railway Environment Variables Setup Script for farmOS
# Run this after deploying to Railway to set up environment variables

echo "Setting up environment variables for farmOS on Railway..."

# These variables will be automatically provided by Railway's PostgreSQL service:
# PGHOST, PGPORT, PGDATABASE, PGUSER, PGPASSWORD

# Additional environment variables you may want to set in Railway dashboard:
echo "Set these in your Railway project settings:"
echo "- DRUPAL_HASH_SALT: $(openssl rand -base64 32)"
echo "- ENVIRONMENT: production"
echo "- TRUSTED_HOST_PATTERNS: your-app-name.railway.app"

# Optional Mapbox configuration
echo ""
echo "Optional - for satellite imagery:"
echo "- MAPBOX_API_KEY: your_mapbox_api_key"

echo ""
echo "Complete setup by visiting your Railway app URL and following the farmOS installation wizard."
