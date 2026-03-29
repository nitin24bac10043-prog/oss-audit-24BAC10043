#!/bin/bash
# ==============================================================
# Script 1: System Identity Report
# Author: Nitin Mudgal | Course: Open Source Software
# Purpose: Displays a welcome-screen-style system identity card
#          showing kernel, user, uptime, distribution, and
#          license information about the running Linux system.
# Concepts: variables, echo, command substitution ($()),
#           basic output formatting
# ==============================================================

# --- Student and project variables ---
STUDENT_NAME="Nitin Mudgal"                # Student's full name
SOFTWARE_CHOICE="Git"                 # Chosen open-source software for the audit

# --- Gathering system information using command substitution ---
KERNEL=$(uname -r)                    # Fetches the running kernel version string
USER_NAME=$(whoami)                   # Gets the currently logged-in username
HOME_DIR=$HOME                        # Captures the user's home directory path
UPTIME=$(uptime -p)                   # Reports uptime in a human-readable format
CURRENT_DATE=$(date '+%A, %d %B %Y')  # Formats the current date (e.g., Monday, 29 March 2026)
CURRENT_TIME=$(date '+%I:%M:%S %p')   # Formats the current time in 12-hour clock

# Extracting the distribution name from /etc/os-release
# The file contains key-value pairs; we grep for PRETTY_NAME and cut out the value
DISTRO_NAME=$(grep -w "PRETTY_NAME" /etc/os-release | cut -d'"' -f2)

# --- Display the system identity report ---
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║           OPEN SOURCE AUDIT — SYSTEM IDENTITY           ║"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║  Student    : $STUDENT_NAME"
echo "║  Software   : $SOFTWARE_CHOICE"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║  Distribution : $DISTRO_NAME"
echo "║  Kernel       : $KERNEL"
echo "║  User         : $USER_NAME"
echo "║  Home Dir     : $HOME_DIR"
echo "║  Uptime       : $UPTIME"
echo "║  Date         : $CURRENT_DATE"
echo "║  Time         : $CURRENT_TIME"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║  OS License   : GNU General Public License v2 (GPLv2)   ║"
echo "║  The Linux kernel is licensed under GPLv2, which        ║"
echo "║  guarantees the freedom to use, study, modify, and      ║"
echo "║  distribute the software. Any derivative work must      ║"
echo "║  also be released under the same license terms.         ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# --- End of Script 1 ---
