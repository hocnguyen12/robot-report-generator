#!/bin/bash

# Clean up previous test artifacts
echo "Cleaning up previous test artifacts..."
rm -f robot_reports/geckodriver-*.log robot_reports/*.png robot_reports/*.jpg robot_reports/*.jpeg 

# Create reports directory if it doesn't exist
mkdir -p robot_reports

# Run robot tests
echo "Running robot tests..."
robot --outputdir robot_reports $@

# Check if tests were successful
if [ $? -eq 0 ]; then
    echo "Tests completed successfully!"
else
    echo "Tests failed!"
fi 