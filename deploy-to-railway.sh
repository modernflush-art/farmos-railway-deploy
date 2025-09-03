#!/bin/bash

# Railway Deployment Script for FarmOS
# This script helps you deploy your FarmOS application to Railway

echo "🚀 FarmOS Railway Deployment Script"
echo "=================================="

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📝 Initializing Git repository..."
    git init
fi

# Check if remote origin exists
if ! git remote get-url origin > /dev/null 2>&1; then
    echo "❌ No GitHub remote found!"
    echo "Please add your GitHub repository as remote:"
    echo "git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git"
    echo ""
    echo "Then run this script again."
    exit 1
fi

echo "✅ Git repository configured"

# Add all files
echo "📦 Adding all files to git..."
git add .

# Commit changes
echo "💾 Committing changes..."
if git commit -m "FarmOS ready for Railway deployment - $(date)"; then
    echo "✅ Changes committed"
else
    echo "ℹ️  No changes to commit (already up to date)"
fi

# Push to GitHub
echo "⬆️  Pushing to GitHub..."
if git push origin main; then
    echo "✅ Code pushed to GitHub successfully"
else
    echo "⚠️  Push failed. You may need to pull first:"
    echo "git pull origin main"
    echo "Then run this script again."
    exit 1
fi

echo ""
echo "🎉 Your code is ready for Railway deployment!"
echo ""
echo "Next steps:"
echo "1. Go to https://railway.app"
echo "2. Click 'New Project' → 'Deploy from GitHub repo'"
echo "3. Select your repository"
echo "4. Add PostgreSQL database service"
echo "5. Wait for deployment to complete"
echo ""
echo "📖 For detailed instructions, see: RAILWAY-DEPLOYMENT-GUIDE.md"
