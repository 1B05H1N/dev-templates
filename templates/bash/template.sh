#!/bin/bash

# Script Name: template.sh
# Description: Bash script template with error handling and logging
# Author: Ibrahim (https://github.com/1B05H1N)
# Date: 2025-05-04

# SCRIPT SETUP AND SAFETY
# ----------------------
# Exit on error (-e) and treat unset variables as errors (-u)
set -eu

# Enable debug mode if DEBUG environment variable is set
if [ "${DEBUG:-}" = "true" ]; then
    set -x
fi

# ENVIRONMENT AND VARIABLES
# ------------------------
# Load environment variables from .env file if it exists
if [ -f .env ]; then
    set -a
    source .env
    set +a
fi

# Set default variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/script.log"
MAX_RETRIES=3
RETRY_DELAY=5

# TEXT PROCESSING EXAMPLES
# -----------------------
# sed: Stream editor for text transformation
# Example: Replace all occurrences of "old" with "new" in a file
# sed -i 's/old/new/g' file.txt

# grep: Search for patterns in files
# Example: Find all lines containing "error" in log files
# grep -r "error" /var/log/

# awk: Text processing and data extraction
# Example: Print the second column of a CSV file
# awk -F',' '{print $2}' data.csv

# FILE OPERATIONS
# --------------
# Check if file exists
if [ -f "$LOG_FILE" ]; then
    echo "Log file exists"
fi

# Create directory if it doesn't exist
mkdir -p "${SCRIPT_DIR}/backup"

# Copy files with error handling
cp -v source.txt "${SCRIPT_DIR}/backup/" || {
    echo "Failed to copy file"
    exit 1
}

# COMMAND LINE ARGUMENTS
# --------------------
# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo "Usage: $0 [options]"
            echo "Options:"
            echo "  -h, --help     Show this help message"
            echo "  -v, --verbose  Enable verbose output"
            echo "  -f, --file     Specify input file"
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -f|--file)
            INPUT_FILE="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# MAIN SCRIPT LOGIC
# ---------------
# Example function with error handling
process_file() {
    local file="$1"
    local retries=0

    while [ $retries -lt $MAX_RETRIES ]; do
        if [ ! -f "$file" ]; then
            echo "Error: File $file does not exist"
            return 1
        fi

        # Process the file
        if process_file_content "$file"; then
            return 0
        else
            retries=$((retries + 1))
            if [ $retries -lt $MAX_RETRIES ]; then
                echo "Retrying in $RETRY_DELAY seconds..."
                sleep $RETRY_DELAY
            fi
        fi
    done

    echo "Failed to process file after $MAX_RETRIES attempts"
    return 1
}

# Example of integrating text processing tools
process_file_content() {
    local file="$1"
    
    # Use grep to find specific content
    if grep -q "error" "$file"; then
        echo "Found error in file"
        return 1
    fi

    # Use sed to modify content
    sed -i 's/old/new/g' "$file"

    # Use awk to process data
    awk '{print $1}' "$file" > "${file}.processed"

    return 0
}

# CLEANUP AND ERROR HANDLING
# ------------------------
# Function to clean up resources
cleanup() {
    echo "Cleaning up..."
    # Add cleanup tasks here
}

# Set up trap to ensure cleanup runs on script exit
trap cleanup EXIT

# Function to handle errors
handle_error() {
    local line="$1"
    local command="$2"
    echo "Error on line $line: $command"
    cleanup
    exit 1
}

# Set up error handling
trap 'handle_error $LINENO "$BASH_COMMAND"' ERR

# SCRIPT EXECUTION
# --------------
# Main function
main() {
    echo "Starting script execution..."
    
    # Add your main script logic here
    if [ -n "${INPUT_FILE:-}" ]; then
        process_file "$INPUT_FILE"
    fi
    
    echo "Script completed successfully"
}

# Execute main function with all arguments
main "$@" 