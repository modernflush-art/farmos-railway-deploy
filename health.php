<?php
/**
 * Health check endpoint for Railway deployment
 * This endpoint verifies that the application is running properly
 */

// Set content type
header('Content-Type: text/plain');

try {
    // Basic health check - ensure PHP is working
    if (!function_exists('phpversion')) {
        http_response_code(500);
        echo "ERROR: PHP not functioning properly";
        exit;
    }

    // Check if we can write to the file system
    $test_file = '/tmp/health_check_test';
    if (file_put_contents($test_file, 'test') === false) {
        http_response_code(500);
        echo "ERROR: Cannot write to file system";
        exit;
    }
    unlink($test_file);

    // All checks passed
    http_response_code(200);
    echo "OK - FarmOS Application Healthy";
    echo "\nPHP Version: " . phpversion();
    echo "\nTimestamp: " . date('Y-m-d H:i:s T');
    
} catch (Exception $e) {
    http_response_code(500);
    echo "ERROR: " . $e->getMessage();
}
?>
