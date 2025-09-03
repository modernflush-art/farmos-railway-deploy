<?php
/**
 * PostgreSQL Database Connection Test Script
 * This script tests the connection to your PostgreSQL database
 */

// Load environment variables from .env file if it exists
if (file_exists(__DIR__ . '/../.env')) {
    $lines = file(__DIR__ . '/../.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos($line, '=') !== false && !str_starts_with($line, '#')) {
            putenv($line);
        }
    }
}

// Database configuration
$db_config = [
    'host' => getenv('DB_HOST') ?: 'localhost',
    'port' => getenv('DB_PORT') ?: '5433',
    'dbname' => getenv('DB_NAME') ?: 'farmos',
    'user' => getenv('DB_USER') ?: 'postgres',
    'password' => getenv('DB_PASSWORD') ?: getenv('POSTGRES_PASSWORD')
];

echo "Testing PostgreSQL Database Connection...\n";
echo "========================================\n";
echo "Host: {$db_config['host']}\n";
echo "Port: {$db_config['port']}\n";
echo "Database: {$db_config['dbname']}\n";
echo "User: {$db_config['user']}\n";
echo "========================================\n";

try {
    // Create PDO connection
    $dsn = "pgsql:host={$db_config['host']};port={$db_config['port']};dbname={$db_config['dbname']}";
    $pdo = new PDO($dsn, $db_config['user'], $db_config['password'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ]);

    echo "✅ Connection successful!\n\n";

    // Test basic queries
    echo "Testing basic operations:\n";
    echo "-------------------------\n";

    // Get PostgreSQL version
    $stmt = $pdo->query("SELECT version()");
    $version = $stmt->fetchColumn();
    echo "✅ PostgreSQL Version: " . substr($version, 0, 50) . "...\n";

    // Check available extensions
    $stmt = $pdo->query("SELECT extname FROM pg_extension ORDER BY extname");
    $extensions = $stmt->fetchAll(PDO::FETCH_COLUMN);
    echo "✅ Available Extensions: " . implode(', ', $extensions) . "\n";

    // Check database size
    $stmt = $pdo->query("SELECT pg_size_pretty(pg_database_size(current_database()))");
    $db_size = $stmt->fetchColumn();
    echo "✅ Database Size: {$db_size}\n";

    // List tables
    $stmt = $pdo->query("
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' 
        ORDER BY table_name
    ");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    echo "✅ Tables in database: " . (count($tables) > 0 ? count($tables) . " tables found" : "No tables yet") . "\n";

    if (count($tables) > 0) {
        echo "   First few tables: " . implode(', ', array_slice($tables, 0, 5)) . "\n";
    }

    echo "\n🎉 All tests passed! Your PostgreSQL database is ready to use.\n";

} catch (PDOException $e) {
    echo "❌ Connection failed: " . $e->getMessage() . "\n";
    echo "\nTroubleshooting tips:\n";
    echo "1. Make sure Docker containers are running: docker-compose up -d\n";
    echo "2. Check if .env file exists with correct database credentials\n";
    echo "3. Verify database host, port, and credentials\n";
    echo "4. Wait a few seconds for PostgreSQL to fully start up\n";
    exit(1);
}
?>
