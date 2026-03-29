#!/bin/bash
# ==============================================================
# Script 3: Disk and Permission Auditor
# Author: Rahul G | Course: Open Source Software
# Purpose: Loops through a list of important system directories
#          and reports disk usage, ownership, and permissions
#          for each directory. Also checks the config directory
#          of the chosen software (Git).
# Concepts: for loop, arrays, df, du, ls -ld, awk, cut,
#           conditional checks
# ==============================================================

# --- Define the list of important system directories to audit ---
# These are standard Linux directories that hold binaries, configs, logs, etc.
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")

# --- The config directory for Git (our chosen software) ---
GIT_CONFIG_DIR="$HOME/.config/git"
GIT_GLOBAL_CONFIG="$HOME/.gitconfig"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║          DISK AND PERMISSION AUDITOR                    ║"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║  Auditing key system directories for permissions,       ║"
echo "║  ownership, and disk usage.                             ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# --- Overall disk usage summary ---
echo "=== Overall Disk Usage ==="
# df -h shows human-readable disk space for all mounted filesystems
df -h / | awk 'NR==1 || NR==2'
echo ""

# --- Audit each directory in the list using a for loop ---
echo "=== Directory Audit Report ==="
echo "--------------------------------------------------------------"
printf "%-15s %-15s %-10s %-10s %s\n" "DIRECTORY" "PERMISSIONS" "OWNER" "GROUP" "SIZE"
echo "--------------------------------------------------------------"

for DIR in "${DIRS[@]}"; do
    # Check if the directory actually exists on this system
    if [ -d "$DIR" ]; then
        # ls -ld shows the directory's own permissions (not its contents)
        # awk extracts: field 1 = permissions, field 3 = owner, field 4 = group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh gives the total size in human-readable format
        # 2>/dev/null suppresses permission-denied errors for protected dirs
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # If du fails or returns empty (e.g., permission denied), show N/A
        if [ -z "$SIZE" ]; then
            SIZE="N/A"
        fi

        # Print the formatted audit row
        printf "%-15s %-15s %-10s %-10s %s\n" "$DIR" "$PERMS" "$OWNER" "$GROUP" "$SIZE"
    else
        # Directory does not exist on this particular system
        printf "%-15s %-15s\n" "$DIR" "[DOES NOT EXIST]"
    fi
done

echo ""

# --- Check the chosen software's (Git) configuration directory ---
echo "=== Git Configuration Audit ==="
echo "--------------------------------------------------------------"

# Check for the global .gitconfig file in the home directory
if [ -f "$GIT_GLOBAL_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_GLOBAL_CONFIG" | awk '{print $1}')
    OWNER=$(ls -l "$GIT_GLOBAL_CONFIG" | awk '{print $3}')
    echo "Global config : $GIT_GLOBAL_CONFIG"
    echo "Permissions   : $PERMS"
    echo "Owner         : $OWNER"
else
    echo "Global config : $GIT_GLOBAL_CONFIG [NOT FOUND]"
    echo "  (Run 'git config --global user.name \"Your Name\"' to create it)"
fi

echo ""

# Check for the .config/git directory (alternative config location)
if [ -d "$GIT_CONFIG_DIR" ]; then
    PERMS=$(ls -ld "$GIT_CONFIG_DIR" | awk '{print $1}')
    OWNER=$(ls -ld "$GIT_CONFIG_DIR" | awk '{print $3}')
    SIZE=$(du -sh "$GIT_CONFIG_DIR" 2>/dev/null | cut -f1)
    echo "Config dir    : $GIT_CONFIG_DIR"
    echo "Permissions   : $PERMS"
    echo "Owner         : $OWNER"
    echo "Size          : $SIZE"
else
    echo "Config dir    : $GIT_CONFIG_DIR [NOT FOUND]"
    echo "  (This is normal — Git uses ~/.gitconfig by default)"
fi

# Also check where the git binary itself is located
GIT_BIN=$(which git 2>/dev/null)
if [ -n "$GIT_BIN" ]; then
    PERMS=$(ls -l "$GIT_BIN" | awk '{print $1}')
    echo ""
    echo "Git binary    : $GIT_BIN"
    echo "Permissions   : $PERMS"
fi

echo ""
echo "=== Audit Complete ==="
echo ""

# --- End of Script 3 ---
