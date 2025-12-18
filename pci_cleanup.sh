#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

LOG_DIR="$1"

if [ -z "$LOG_DIR" ]; then
    echo "Usage: $0 <log_directory>"
    exit 1
fi

echo "🔍 Previewing files containing 'Linux' (case-insensitive):"
grep -lir "Linux" "$LOG_DIR" || echo "No files found or limited output for safety."

echo
read -p "⚠️ Do you want to delete ONLY regular files listed above? (yes/no): " confirm

if [ "$confirm" = "yes" ]; then
    grep -lir "Linux" "$LOG_DIR" | while read file
    do
        if [ -f "$file" ]; then
            rm -f "$file"
            echo "Deleted: $file"
        fi
    done
else
    echo "❌ Cleanup aborted."
fi
