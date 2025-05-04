#!/usr/bin/env bash

# Script Name: file_backup.sh
# Description: Example bash script demonstrating file backup functionality
# Author: Ibrahim (https://github.com/1B05H1N)
# Date: 2025-05-04

# Exit on error
set -e

# Enable debug mode if DEBUG is set
if [ "$DEBUG" = "true" ]; then
    set -x
fi

# Load environment variables
if [ -f .env ]; then
    source .env
fi

# Default configuration
BACKUP_DIR="${BACKUP_DIR:-./backups}"
MAX_BACKUPS="${MAX_BACKUPS:-5}"

# Function to display usage
usage() {
    echo "Usage: $0 [options] <source_file>"
    echo "Options:"
    echo "  -h, --help     Display this help message"
    echo "  -d, --dir      Specify backup directory (default: $BACKUP_DIR)"
    echo "  -m, --max      Maximum number of backups to keep (default: $MAX_BACKUPS)"
    exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -d|--dir)
            BACKUP_DIR="$2"
            shift
            ;;
        -m|--max)
            MAX_BACKUPS="$2"
            shift
            ;;
        *)
            SOURCE_FILE="$1"
            ;;
    esac
    shift
done

# Validate arguments
if [ -z "$SOURCE_FILE" ]; then
    echo "Error: Source file not specified"
    usage
fi

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file does not exist: $SOURCE_FILE"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Generate backup filename with timestamp
BACKUP_FILE="$BACKUP_DIR/$(basename "$SOURCE_FILE").$(date +%Y%m%d_%H%M%S).bak"

# Create backup
echo "Creating backup of $SOURCE_FILE..."
cp "$SOURCE_FILE" "$BACKUP_FILE"

# Verify backup
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: Backup failed"
    exit 1
fi

echo "Backup created successfully: $BACKUP_FILE"

# Clean up old backups
echo "Cleaning up old backups..."
ls -t "$BACKUP_DIR"/*.bak 2>/dev/null | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm

echo "Backup process completed successfully" 