#!/bin/bash

# Get the absolute path of the script's directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create test downloads directory with absolute path
TEST_DOWNLOADS_DIR="${SCRIPT_DIR}/test_downloads"
mkdir -p "$TEST_DOWNLOADS_DIR"

# Clean up previous test artifacts
echo "Cleaning up previous test artifacts..."
rm -f robot_reports/geckodriver-*.log robot_reports/*.png robot_reports/*.jpg robot_reports/*.jpeg 

# Create reports directory if it doesn't exist
mkdir -p robot_reports

# Run robot tests with custom download directory
echo "Running robot tests..."
robot --variable DOWNLOAD_DIR:"$TEST_DOWNLOADS_DIR" --outputdir robot_reports $@

# Clean up downloaded files
echo "Cleaning up downloaded files..."
rm -rf "$TEST_DOWNLOADS_DIR"/*

# Check if tests were successful
if [ $? -eq 0 ]; then
    echo "Tests completed successfully!"
else
    echo "Tests failed!"
fi 