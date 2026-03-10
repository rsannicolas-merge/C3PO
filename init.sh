#!/bin/bash

# C3PO Initialization Script
# Sets up the unified security operations command center

echo "🤖 Initializing C3PO - Chief Command & Control Protocol Operations"
echo "=================================================================="

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p security/{sec-gemini,corsair,drm-lab}
mkdir -p compliance/{hitrust,evidence,policies}
mkdir -p operations/{incident-response,monitoring,automation}
mkdir -p workspace/{active,archive}
mkdir -p .claude/{commands,agents,skills}
mkdir -p docs
mkdir -p logs

# Check for required environment variables
echo "🔐 Checking environment configuration..."
if [ ! -f .env ]; then
    echo "⚠️  No .env file found. Creating from template..."
    cat > .env.template << 'EOF'
# C3PO Environment Configuration

# GitHub Integration
GITHUB_TOKEN=your_github_token_here
GITHUB_REPO_OWNER=your_org
VENDORS_REPO_NAME=vendors
CONTRACTS_REPO_NAME=contracts

# Google Cloud Platform
GCP_PROJECT_ID=your_project_id
GCP_REGION=us-central1
VERTEX_AI_LOCATION=us-central1

# Sec-Gemini Configuration
SEC_GEMINI_API_KEY=your_api_key
SEC_GEMINI_ENDPOINT=https://secgemini.google

# Corsair CPOE Configuration
CORSAIR_DOMAIN=agency.gov
CORSAIR_KEY_DIR=./keys
CORSAIR_MAPPING_DIR=./mappings

# Vanta Integration
VANTA_API_KEY=your_vanta_key
VANTA_API_URL=https://api.vanta.com

# Jira Integration
JIRA_URL=https://your-org.atlassian.net
JIRA_USER=your_email
JIRA_API_TOKEN=your_token

# Slack Notifications
SLACK_WEBHOOK_URL=your_webhook_url
SLACK_CHANNEL=#security-alerts

# Database
DATABASE_URL=sqlite:///./c3po.db

# Logging
LOG_LEVEL=INFO
LOG_FILE=./logs/c3po.log
EOF
    echo "✅ Created .env.template - Please configure with your values"
fi

# Initialize Git repository if not present
if [ ! -d .git ]; then
    echo "📦 Initializing Git repository..."
    git init
    echo ".env" >> .gitignore
    echo "logs/" >> .gitignore
    echo "workspace/active/" >> .gitignore
    echo "*.jwt" >> .gitignore
    echo "keys/" >> .gitignore
fi

# Create initial documentation
echo "📚 Creating documentation..."
cat > docs/quickstart.md << 'EOF'
# C3PO Quick Start Guide

## Initial Setup
1. Copy `.env.template` to `.env` and configure
2. Install dependencies (if any)
3. Run `claude-code .` to launch

## Common Commands
- `/security-scan logs` - Analyze security logs
- `/cpoe-manage sign --file evidence.json` - Sign compliance evidence
- `/hitrust-prep r2 gap-analysis` - HITRUST gap assessment
- `/incident-response P1 security "Potential breach detected"`
- `/devsecops-review full` - Complete DevSecOps assessment

## Getting Help
- Check `/help` for available commands
- Review agent capabilities in `.claude/agents/`
- See command details in `.claude/commands/`
EOF

# Create workspace readme
cat > workspace/README.md << 'EOF'
# C3PO Workspace

## Active Projects
Place current investigations and active projects in `active/`

## Archived Projects
Completed projects move to `archive/` with timestamp

## Naming Convention
- `YYYY-MM-DD-project-name/`
- Example: `2026-03-04-hitrust-gap-assessment/`
EOF

# Download or link external tools (placeholder)
echo "🔧 Checking external tool integrations..."
# This would check for sec-gemini CLI, corsair CLI, etc.

# Final status
echo ""
echo "✅ C3PO initialization complete!"
echo ""
echo "Next steps:"
echo "1. Configure your .env file with actual values"
echo "2. Launch with: claude-code ."
echo "3. Run /help to see available commands"
echo ""
echo "🚀 C3PO is ready for duty!"