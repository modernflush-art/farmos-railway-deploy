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

# Create healthcheck endpoint
RUN echo '<?php echo "OK"; ?>' > /opt/drupal/web/health.php

# Expose port 80
EXPOSE 80

# Health check for Railway
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost/health.php || exit 1

# Start Apache
CMD ["apache2-foreground"]
