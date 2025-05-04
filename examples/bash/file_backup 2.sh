#!/usr/bin/env bash

# Script Name: file_backup.sh
# Description: Creates incremental backups of specified directories
# Author: Ibrahim (https://github.com/1B05H1N)
# Date: 2025-05-04

# Load environment variables
source .env

# Default configuration
BACKUP_DIR="${BACKUP_DIR:-./backups}"
SOURCE_DIR="${SOURCE_DIR:-./data}"
MAX_BACKUPS="${MAX_BACKUPS:-5}"
COMPRESS="${COMPRESS:-true}"

# Function to create backup
create_backup() {
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_name="backup_${timestamp}"
    local backup_path="${BACKUP_DIR}/${backup_name}"

    # Create backup directory if it doesn't exist
    mkdir -p "${BACKUP_DIR}"

    # Create backup
    if [ "${COMPRESS}" = "true" ]; then
        tar -czf "${backup_path}.tar.gz" -C "${SOURCE_DIR}" .
    else
        cp -r "${SOURCE_DIR}" "${backup_path}"
    fi

    # Clean up old backups
    if [ "${MAX_BACKUPS}" -gt 0 ]; then
        ls -t "${BACKUP_DIR}"/*.tar.gz 2>/dev/null | tail -n +$((MAX_BACKUPS + 1)) | xargs -r rm
    fi

    echo "Backup created: ${backup_path}"
}

# Function to restore backup
restore_backup() {
    local backup_file="$1"
    local restore_dir="${2:-./restored}"

    if [ ! -f "${backup_file}" ]; then
        echo "Error: Backup file not found: ${backup_file}"
        exit 1
    fi

    mkdir -p "${restore_dir}"
    
    if [[ "${backup_file}" == *.tar.gz ]]; then
        tar -xzf "${backup_file}" -C "${restore_dir}"
    else
        cp -r "${backup_file}" "${restore_dir}"
    fi

    echo "Backup restored to: ${restore_dir}"
}

# Function to list backups
list_backups() {
    echo "Available backups:"
    ls -l "${BACKUP_DIR}"/*.tar.gz 2>/dev/null || echo "No backups found"
}

# Main function
main() {
    local action="$1"
    local backup_file="$2"
    local restore_dir="$3"

    case "${action}" in
        create)
            create_backup
            ;;
        restore)
            restore_backup "${backup_file}" "${restore_dir}"
            ;;
        list)
            list_backups
            ;;
        *)
            echo "Usage: $0 {create|restore|list} [backup_file] [restore_dir]"
            exit 1
            ;;
    esac
}

# Execute main function with all arguments
main "$@" 