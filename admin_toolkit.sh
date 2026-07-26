#!/bin/bash
# Script Name: admin_toolkit.sh
# Author: Kevin with Smart Mode Copilot assistance (powered by GPT-5)
# Date: 2026-07-24
# Purpose: Minimal administrative toolkit with logging.
# Usage: ./admin_toolkit.sh


LOGFILE="$HOME/admin_toolkit.log"
TARGET_DIR="$HOME"
TIMESTAMP=$(date)

log() {
    echo "[$(date)] $1" | tee -a "$LOGFILE"
}


validate_dir() {
    [[ -d "$1" ]]
}

log "SCRIPT STARTED"

# Task 1: Hostname
log "Hostname: $(hostname)"

# Task 2: Date/time
log "Current Date/Time: $TIMESTAMP"

# Task 3: Current user
log "Current User: $USER"

# Task 4: Disk usage
log "Disk Usage:"
df -h >> "$LOGFILE"

# Task 5: Memory usage
log "Memory Usage:"
free -h >> "$LOGFILE"

# Conditional check 
if validate_dir "/etc"; then
    log "/etc directory exists."
else
    log "ERROR: /etc directory missing!"
fi

# Loop (required)
for DIR in "/home" "/tmp" "/var"; do
    if validate_dir "$DIR"; then
        log "Directory OK: $DIR"
    else
        log "Directory MISSING: $DIR"
    fi
done

# Backup task 
BACKUP_FILE="$HOME/backup_$(date +%Y%m%d).tar.gz"
tar -czf "$BACKUP_FILE" "$TARGET_DIR" 2>>"$LOGFILE"

if [[ $? -eq 0 ]]; then
    log "Backup created: $BACKUP_FILE"
else
    log "ERROR: Backup failed."
fi

log "SCRIPT COMPLETED"
echo "Done. Log saved to $LOGFILE."
