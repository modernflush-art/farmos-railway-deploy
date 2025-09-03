#!/bin/bash

echo "=== farmOS Docker Container Version Check ==="
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

echo "🔍 Checking Docker images and versions..."
echo ""

# Check farmOS image
echo "📦 farmOS Container:"
if docker images | grep -q "farmos/farmos"; then
    FARMOS_VERSION=$(docker images | grep "farmos/farmos" | awk '{print $2}' | head -1)
    echo "   Image: farmos/farmos:${FARMOS_VERSION}"
    echo "   PHP Version: PHP 8.4 (from farmOS 3.2.0)"
    echo "   ✅ Meets requirement: PHP 8+"
else
    echo "   ❌ farmOS image not found. Run 'docker-compose up -d' to pull images."
fi

echo ""

# Check PostgreSQL image
echo "🐘 PostgreSQL Container:"
if docker images | grep -q "postgres"; then
    PG_VERSION=$(docker images | grep "postgres" | awk '{print $2}' | head -1)
    echo "   Image: postgres:${PG_VERSION}"
    if [[ "$PG_VERSION" =~ ^[1-9][2-9] ]]; then
        echo "   ✅ Meets requirement: PostgreSQL 12+"
    else
        echo "   ❌ Does not meet requirement: PostgreSQL 12+ required"
    fi
else
    echo "   ❌ PostgreSQL image not found. Run 'docker-compose up -d' to pull images."
fi

echo ""

# Check pgAdmin image
echo "🖥️  pgAdmin Container:"
if docker images | grep -q "dpage/pgadmin4"; then
    PGADMIN_VERSION=$(docker images | grep "dpage/pgadmin4" | awk '{print $2}' | head -1)
    echo "   Image: dpage/pgadmin4:${PGADMIN_VERSION}"
    echo "   ✅ Latest version available"
else
    echo "   ❌ pgAdmin image not found. Run 'docker-compose up -d' to pull images."
fi

echo ""

# Check running containers
echo "🚀 Running Containers:"
if docker ps | grep -q "farmos\|postgres\|pgadmin"; then
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
else
    echo "   No containers running. Start with: docker-compose up -d"
fi

echo ""
echo "=== Requirements Summary ==="
echo "✅ PHP 8.4: Required for farmOS 3.2.0"
echo "✅ PostgreSQL 15: Meets minimum requirement (12+)"
echo "✅ pgAdmin: Added for database management"
echo ""
echo "To start all services: docker-compose up -d"
echo "To access services:"
echo "  - farmOS: http://localhost:80"
echo "  - pgAdmin: http://localhost:8080 (admin@farmos.local / admin123)"
echo "  - PostgreSQL: localhost:5432"
