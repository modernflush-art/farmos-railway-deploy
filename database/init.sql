-- PostgreSQL initialization script for FarmOS
-- This script will be executed when the PostgreSQL container starts for the first time

-- Create additional databases if needed
-- CREATE DATABASE farmos_backup;
-- CREATE DATABASE farmos_test;

-- Enable required PostgreSQL extensions
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS unaccent;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create a read-only user for reporting/backup purposes
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'farmos_readonly') THEN
        CREATE USER farmos_readonly WITH PASSWORD 'readonly_password_2024';
        GRANT CONNECT ON DATABASE farmos TO farmos_readonly;
        GRANT USAGE ON SCHEMA public TO farmos_readonly;
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO farmos_readonly;
        ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO farmos_readonly;
    END IF;
END
$$;

-- Optimize PostgreSQL settings for FarmOS
-- Note: These settings will be added to postgresql.conf via docker volumes
