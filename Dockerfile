FROM farmos/farmos:3.2.0

# Copy custom PHP configuration
COPY php.ini /usr/local/etc/php/conf.d/farmos.ini

# Install additional PHP extensions for Railway deployment
RUN apt-get update && apt-get install -y \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Ensure proper permissions for sites directory
RUN mkdir -p /opt/drupal/web/sites/default/private/files && \
    chown -R www-data:www-data /opt/drupal/web/sites && \
    chmod -R 770 /opt/drupal/web/sites/default/private

# Copy healthcheck endpoint and startup script
COPY health.php /opt/drupal/web/health.php
COPY startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Expose port 80
EXPOSE 80

# Remove Docker healthcheck for Railway (Railway will handle this)
# HEALTHCHECK disabled for Railway deployment

# Use startup script
CMD ["/usr/local/bin/startup.sh"]
