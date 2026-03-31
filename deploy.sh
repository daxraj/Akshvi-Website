#!/bin/bash
# ============================================================
#  Akshvi Website — Deployment Script (for Claude Code / Terminal)
#  Usage: bash deploy.sh
# ============================================================

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║   AKSHVI — Website Deployment Script         ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════╝${NC}"
echo ""

# -----------------------------------------------------------
# Step 1: Check prerequisites
# -----------------------------------------------------------
echo -e "${YELLOW}[1/5] Checking prerequisites...${NC}"

if ! command -v git &> /dev/null; then
    echo -e "${RED}✗ Git is not installed. Install it first:${NC}"
    echo "  sudo apt install git    (Linux)"
    echo "  brew install git        (Mac)"
    exit 1
fi
echo -e "${GREEN}✓ Git is installed${NC}"

# -----------------------------------------------------------
# Step 2: Initialize Git repo (if not already)
# -----------------------------------------------------------
echo -e "${YELLOW}[2/5] Setting up Git repository...${NC}"

if [ ! -d ".git" ]; then
    git init
    git branch -M main
    echo -e "${GREEN}✓ Git repository initialized (branch: main)${NC}"
else
    echo -e "${GREEN}✓ Git repository already exists${NC}"
fi

# -----------------------------------------------------------
# Step 3: Stage and commit files
# -----------------------------------------------------------
echo -e "${YELLOW}[3/5] Staging and committing files...${NC}"

git add -A

# Check if there are changes to commit
if git diff --cached --quiet 2>/dev/null; then
    echo -e "${GREEN}✓ No new changes to commit${NC}"
else
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    git commit -m "Deploy Akshvi website — $TIMESTAMP"
    echo -e "${GREEN}✓ Changes committed${NC}"
fi

# -----------------------------------------------------------
# Step 4: Push to GitHub
# -----------------------------------------------------------
echo -e "${YELLOW}[4/5] Pushing to GitHub...${NC}"

# Check if remote 'origin' exists
if git remote get-url origin &> /dev/null; then
    echo -e "${GREEN}✓ Remote 'origin' is set to: $(git remote get-url origin)${NC}"
    git push -u origin main
    echo -e "${GREEN}✓ Code pushed to GitHub${NC}"
else
    echo ""
    echo -e "${RED}✗ No remote 'origin' set yet.${NC}"
    echo ""
    echo -e "${CYAN}Run these commands with YOUR GitHub repo URL:${NC}"
    echo ""
    echo "  git remote add origin https://github.com/YOUR_USERNAME/akshvi-website.git"
    echo "  git push -u origin main"
    echo ""
    echo -e "${YELLOW}(Create the repo on GitHub first → github.com/new)${NC}"
    exit 0
fi

# -----------------------------------------------------------
# Step 5: Done!
# -----------------------------------------------------------
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ✓ Deployment push complete!                ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}Next: If you've set up the Hostinger webhook,${NC}"
echo -e "${CYAN}your website will auto-update within ~60 seconds.${NC}"
echo ""
