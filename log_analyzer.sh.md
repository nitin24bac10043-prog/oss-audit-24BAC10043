#!/bin/bash
# ==============================================================
# Script 4: Log File Analyzer
# Author: Nitin Mudgal | Course: Open Source Software
# Purpose: Reads a log file line by line, counts occurrences
#          of a keyword (like ERROR or WARNING), prints a
#          summary, and shows the last 5 matching lines.
# Usage:   ./log_analyzer.sh /var/log/syslog [keyword]
# Concepts: while-read loop, if-then, counter variables,
#           command-line arguments ($1, $2), grep, tail
# ==============================================================

# --- Command-line arguments ---
# $1 is the log file path; $2 is the search keyword (defaults to "error")
LOGFILE="$1"
KEYWORD="${2:-error}"   # If no keyword is given, default to "error"
COUNT=0                 # Initialize the match counter to zero
TOTAL_LINES=0           # Track total lines read

# --- Input validation ---
# Check if the user provided a log file argument at all
if [ -z "$LOGFILE" ]; then
    echo ""
    echo "Usage: $0 <logfile> [keyword]"
    echo "Example: $0 /var/log/syslog error"
    echo ""
    exit 1
fi

# Check if the specified file actually exists and is a regular file
if [ ! -f "$LOGFILE" ]; then
    echo ""
    echo "Error: File '$LOGFILE' not found."
    echo "Please provide a valid log file path."
    echo ""

    # --- Retry mechanism (do-while style) ---
    # If the file does not exist, prompt the user to enter a valid path
    # This demonstrates a do-while style retry loop
    RETRY="yes"
    while [ "$RETRY" = "yes" ]; do
        read -p "Enter a valid log file path (or 'quit' to exit): " LOGFILE

        # Allow the user to quit gracefully
        if [ "$LOGFILE" = "quit" ]; then
            echo "Exiting."
            exit 0
        fi

        # Check the new path
        if [ -f "$LOGFILE" ]; then
            echo "File found. Proceeding with analysis..."
            RETRY="no"   # Break out of the retry loop
        else
            echo "Error: '$LOGFILE' still not found. Try again."
        fi
    done
fi

# --- Check if the file is empty ---
if [ ! -s "$LOGFILE" ]; then
    echo ""
    echo "Warning: '$LOGFILE' is empty (0 bytes)."
    echo "No lines to analyze."
    echo ""
    exit 0
fi

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║          LOG FILE ANALYZER                              ║"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║  File    : $LOGFILE"
echo "║  Keyword : $KEYWORD"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# --- Read the file line by line using a while-read loop ---
# IFS= prevents leading/trailing whitespace from being stripped
# read -r prevents backslash interpretation
while IFS= read -r LINE; do
    # Increment total line counter for every line read
    TOTAL_LINES=$((TOTAL_LINES + 1))

    # Check if the current line contains the keyword (case-insensitive)
    # grep -i performs case-insensitive matching
    # grep -q suppresses output; we only care about the exit status
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment keyword match counter
    fi
done < "$LOGFILE"

# --- Print summary ---
echo "=== Analysis Summary ==="
echo "Total lines scanned : $TOTAL_LINES"
echo "Keyword matches     : $COUNT"
echo "Keyword searched    : '$KEYWORD'"
echo ""

# --- Display the last 5 matching lines ---
# tail + grep combination: grep finds all matches, tail shows last 5
echo "=== Last 5 Matching Lines ==="
echo "--------------------------------------------------------------"
MATCHING_LINES=$(grep -in "$KEYWORD" "$LOGFILE" | tail -5)

# Check if there were any matching lines to display
if [ -n "$MATCHING_LINES" ]; then
    echo "$MATCHING_LINES"
else
    echo "(No lines matched the keyword '$KEYWORD')"
fi

echo "--------------------------------------------------------------"
echo ""
echo "=== Analysis Complete ==="
echo ""

# --- End of Script 4 ---
