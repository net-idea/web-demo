#!/bin/bash

# Web Demo Development Environment Startup Script
# This script sets up and starts the local development environment

set -e

echo "================================"
echo "Web Demo Development Environment"
echo "================================"
echo ""

# Check if composer is installed
if ! command -v composer &> /dev/null; then
    echo "Error: Composer is not installed. Please install Composer first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "Error: npm is not installed. Please install Node.js and npm first."
    exit 1
fi

# Check if PHP is installed
if ! command -v php &> /dev/null; then
    echo "Error: PHP is not installed. Please install PHP 8.2 or higher."
    exit 1
fi

echo "✓ Prerequisites check passed"
echo ""

# Install PHP dependencies
if [ ! -d "vendor" ]; then
    echo "Installing PHP dependencies..."
    composer install
    echo ""
fi

# Install Node dependencies
if [ ! -d "node_modules" ]; then
    echo "Installing Node.js dependencies..."
    npm install
    echo ""
fi

# Build frontend assets
if [ ! -d "public/build" ]; then
    echo "Building frontend assets..."
    npm run build
    echo ""
fi

# Clear Symfony cache
echo "Clearing Symfony cache..."
php bin/console cache:clear
echo ""

# Start Webpack Dev Server in background
echo "Starting Webpack Dev Server..."
npm run dev-server &
WEBPACK_PID=$!
echo "Webpack Dev Server started (PID: $WEBPACK_PID)"
echo ""

# Wait a moment for webpack to start
sleep 3

# Start Symfony Development Server
echo "Starting Symfony Development Server..."
echo "================================"
echo ""
echo "Application is now running!"
echo "- Web: http://127.0.0.1:8000"
echo "- Webpack Dev Server: http://127.0.0.1:8080"
echo ""
echo "Press Ctrl+C to stop all servers"
echo ""

# Trap Ctrl+C and cleanup
trap "echo ''; echo 'Stopping servers...'; kill $WEBPACK_PID 2>/dev/null; exit" INT TERM

# Start Symfony server
php -S 127.0.0.1:8000 -t public
