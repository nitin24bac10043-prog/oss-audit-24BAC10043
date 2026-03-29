#!/bin/bash
# ==============================================================
# Script 5: Open Source Manifesto Generator
# Author: Nitin Mudgal | Course: Open Source Software
# Purpose: Generates a personalised open-source philosophy
#          statement by asking the user three questions,
#          composing a paragraph from the answers, and saving
#          it to a timestamped .txt file.
# Concepts: read for user input, string concatenation,
#           writing to a file with > and >>, date command,
#           aliases (demonstrated via comments)
# ==============================================================

# --- Alias demonstration ---
# In bash, aliases are shortcuts for longer commands. For example:
# alias ll='ls -la'        → typing 'll' runs 'ls -la'
# alias gs='git status'    → typing 'gs' runs 'git status'
# alias update='sudo apt update && sudo apt upgrade -y'
# Aliases are typically defined in ~/.bashrc or ~/.bash_aliases
# They are best suited for interactive shells, not scripts,
# because scripts run in a non-interactive subshell where
# aliases are not expanded by default.

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║     THE OPEN SOURCE MANIFESTO GENERATOR                 ║"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║  Answer three short questions to generate your very     ║"
echo "║  own open-source philosophy manifesto.                  ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# --- Gather user input using read ---
# read -p displays a prompt and stores the response in a variable
read -p "1. Name one open-source tool you use every day: " TOOL
read -p "2. In one word, what does 'freedom' mean to you? " FREEDOM
read -p "3. Name one thing you would build and share freely: " BUILD

# --- Capture metadata using command substitution ---
DATE=$(date '+%d %B %Y')           # Human-readable date (e.g., 29 March 2026)
TIMESTAMP=$(date '+%Y%m%d_%H%M%S') # Machine-friendly timestamp for the filename
USERNAME=$(whoami)                  # Current Linux username

# --- Construct the output filename ---
OUTPUT="manifesto_${USERNAME}_${TIMESTAMP}.txt"

# --- Compose the manifesto paragraph ---
# Using > to create the file (overwrites if it exists)
# and >> to append additional lines
echo "===================================================" > "$OUTPUT"
echo "   MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "   Generated on $DATE by $USERNAME" >> "$OUTPUT"
echo "===================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# String concatenation: building sentences from variables and literal text
echo "I believe in the power of open source. Every day, I rely on $TOOL — a tool that was built by people who chose to share their work with the world rather than lock it behind closed doors. To me, freedom means $FREEDOM. It is not just a word; it is a principle that shapes how I think about technology, collaboration, and the responsibility we carry as developers." >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo "If I could build one thing and share it freely with the world, it would be $BUILD. Not because I expect recognition or reward, but because I have seen what happens when knowledge flows without barriers — it multiplies. The tools I depend on today exist because someone, somewhere, made the same choice." >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo "Open source is not charity. It is the most practical form of engineering there is. When code is open, bugs are found faster, features are shaped by real needs, and no single company can hold the world's infrastructure hostage. I stand on the shoulders of thousands of contributors, and I intend to add my own shoulders to that foundation." >> "$OUTPUT"
echo "" >> "$OUTPUT"

echo "This is my manifesto. Written on $DATE. Signed by $USERNAME." >> "$OUTPUT"
echo "===================================================" >> "$OUTPUT"

# --- Display the result to the terminal ---
echo ""
echo "Your manifesto has been generated and saved."
echo ""
echo "--- BEGIN MANIFESTO ---"
cat "$OUTPUT"
echo "--- END MANIFESTO ---"
echo ""
echo "Saved to: $(pwd)/$OUTPUT"
echo ""

# --- End of Script 5 ---
