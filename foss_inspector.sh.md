#!/bin/bash
# ==============================================================
# Script 2: FOSS Package Inspector
# Author: Nitin Mudgal | Course: Open Source Software
# Purpose: Checks whether a specified open-source package is
#          installed on the system, displays its version and
#          license info, and prints a short philosophy note
#          using a case statement.
# Concepts: if-then-else, case statement, dpkg/rpm, pipe, grep
# ==============================================================

# --- Define the package to inspect ---
# Default package is 'git'; user can override by passing an argument
PACKAGE="${1:-git}"

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║          FOSS PACKAGE INSPECTOR                         ║"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║  Inspecting package: $PACKAGE"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# --- Check if the package is installed ---
# We first try dpkg (Debian/Ubuntu systems), then fall back to rpm (Red Hat/Fedora)
if command -v dpkg &>/dev/null; then
    # On Debian-based systems, dpkg -s gives package status
    if dpkg -s "$PACKAGE" &>/dev/null; then
        echo "[INSTALLED] $PACKAGE is present on this system."
        echo ""
        echo "--- Package Details ---"
        # Extract key fields using grep with extended regex
        dpkg -s "$PACKAGE" | grep -E '^(Version|Description|Maintainer|Homepage):'
        echo ""
    else
        echo "[NOT INSTALLED] $PACKAGE is not found on this system."
        echo "You can install it with: sudo apt install $PACKAGE"
        echo ""
    fi
elif command -v rpm &>/dev/null; then
    # On RPM-based systems, rpm -qi gives detailed package info
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "[INSTALLED] $PACKAGE is present on this system."
        echo ""
        echo "--- Package Details ---"
        rpm -qi "$PACKAGE" | grep -E 'Version|License|Summary'
        echo ""
    else
        echo "[NOT INSTALLED] $PACKAGE is not found on this system."
        echo "You can install it with: sudo yum install $PACKAGE"
        echo ""
    fi
else
    # Neither dpkg nor rpm is available
    echo "[WARNING] Could not detect package manager (dpkg or rpm)."
    echo "Manual verification is needed."
fi

# --- Philosophy note using a case statement ---
# The case statement matches the package name and prints a contextual
# one-line philosophical note about each open-source project
echo "--- Open Source Philosophy Note ---"
case "$PACKAGE" in
    git)
        echo "Git: Born from necessity when proprietary tools failed the Linux community."
        echo "Linus Torvalds built Git in 2005 to prove that version control could be"
        echo "fast, distributed, and free — and it changed how the world writes software."
        ;;
    apache2|httpd)
        echo "Apache: The web server that built the open internet. Over half the world's"
        echo "websites once ran on Apache, proving that community-driven software can"
        echo "outperform any corporate product."
        ;;
    mysql-server|mysql)
        echo "MySQL: Open source at the heart of millions of applications. Its dual-license"
        echo "model tells a complex story about balancing community freedom with commercial"
        echo "sustainability."
        ;;
    firefox)
        echo "Firefox: A nonprofit's stand for an open web. Mozilla chose principles over"
        echo "profit, reminding us that browsers are not just software — they are gateways"
        echo "to human knowledge."
        ;;
    vlc)
        echo "VLC: Built by students at the Ecole Centrale Paris who just wanted to stream"
        echo "video freely. It now plays anything, anywhere, and asks for nothing in return."
        ;;
    python3|python)
        echo "Python: A language shaped entirely by its community. Guido van Rossum gave"
        echo "the world a tool that prioritises readability and accessibility, and the"
        echo "community has made it the language of science, education, and automation."
        ;;
    libreoffice)
        echo "LibreOffice: Born from a community fork when Oracle threatened OpenOffice's"
        echo "future. It proved that a committed community can rescue essential software"
        echo "from corporate control."
        ;;
    *)
        # Default case for any package not explicitly listed above
        echo "$PACKAGE: Every open-source package carries a story of someone who chose"
        echo "to share their work freely. That choice is what makes the ecosystem work."
        ;;
esac

echo ""
# --- End of Script 2 ---
