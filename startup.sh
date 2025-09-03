#!/bin/bash

# FarmOS Startup Script for Railway
echo "Starting FarmOS application..."

# Ensure proper permissions
chown -R www-data:www-data /opt/drupal/web/sites
chmod -R 755 /opt/drupal/web/sites

# Create necessary directories
mkdir -p /opt/drupal/web/sites/default/files
mkdir -p /opt/drupal/web/sites/default/private/files
chown -R www-data:www-data /opt/drupal/web/sites/default/files
chown -R www-data:www-data /opt/drupal/web/sites/default/private/files

# Set proper permissions for files directories
chmod -R 775 /opt/drupal/web/sites/default/files
chmod -R 770 /opt/drupal/web/sites/default/private/files

echo "Permissions set successfully"

# Start Apache in foreground
echo "Starting Apache..."
exec apache2-foreground
