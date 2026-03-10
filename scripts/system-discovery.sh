#!/bin/bash
# System Discovery Script - Find Unknown Assets
# Purpose: Discover and inventory all systems in GCP, GitHub, and network
# Author: CISO Security Operations
# Created: 2026-03-09

set -euo pipefail

# Configuration
OUTPUT_DIR="/Users/rsannicolas/Documents/GitHub/C3PO/workspace/discovery-results"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
REPORT_FILE="$OUTPUT_DIR/discovery_report_$TIMESTAMP.md"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Initialize report
cat > "$REPORT_FILE" <<EOF
# System Discovery Report
*Generated: $(date -u +"%Y-%m-%d %H:%M:%S UTC")*
*Scan Type: Comprehensive Asset Discovery*

## Executive Summary
Automated discovery scan to identify unknown systems and close inventory gaps.

---

EOF

echo "🔍 Starting system discovery scan..."
echo "📁 Results will be saved to: $REPORT_FILE"

# Function to append to report
report() {
    echo "$1" >> "$REPORT_FILE"
}

# 1. GCP Project Discovery
echo "☁️  Scanning Google Cloud Platform..."
report "## Google Cloud Platform Assets"
report ""

# Check if gcloud is configured
if command -v gcloud &> /dev/null; then
    report "### GCP Projects"
    report '```'
    gcloud projects list --format="table(projectId,name,createTime)" 2>/dev/null >> "$REPORT_FILE" || report "Error: Unable to list projects"
    report '```'
    report ""

    # Get active project
    ACTIVE_PROJECT=$(gcloud config get-value project 2>/dev/null || echo "none")

    if [[ "$ACTIVE_PROJECT" != "none" ]]; then
        report "### Compute Instances (Project: $ACTIVE_PROJECT)"
        report '```'
        gcloud compute instances list --format="table(name,zone,machineType,status)" 2>/dev/null >> "$REPORT_FILE" || report "No compute instances found"
        report '```'
        report ""

        report "### Cloud Run Services"
        report '```'
        gcloud run services list --format="table(SERVICE,REGION,URL)" 2>/dev/null >> "$REPORT_FILE" || report "No Cloud Run services found"
        report '```'
        report ""

        report "### App Engine Services"
        report '```'
        gcloud app services list --format="table(SERVICE,VERSION.ID)" 2>/dev/null >> "$REPORT_FILE" || report "No App Engine services found"
        report '```'
        report ""

        report "### Cloud SQL Instances"
        report '```'
        gcloud sql instances list --format="table(name,databaseVersion,region)" 2>/dev/null >> "$REPORT_FILE" || report "No Cloud SQL instances found"
        report '```'
        report ""

        report "### Storage Buckets"
        report '```'
        gsutil ls 2>/dev/null | head -20 >> "$REPORT_FILE" || report "Unable to list storage buckets"
        report '```'
        report ""
    fi
else
    report "⚠️ gcloud CLI not installed or configured"
fi

# 2. GitHub Repository Discovery
echo "🐙 Scanning GitHub repositories..."
report "## GitHub Repositories"
report ""

if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    report "### Organization Repositories"
    report '```'
    curl -s -H "Authorization: token $GITHUB_TOKEN" \
        "https://api.github.com/user/repos?per_page=100" | \
        jq -r '.[] | "\(.full_name) - \(.description // "No description")"' >> "$REPORT_FILE" 2>/dev/null || report "Error accessing GitHub API"
    report '```'
    report ""
else
    report "⚠️ GITHUB_TOKEN not set - skipping GitHub discovery"
fi

# 3. Docker Container Discovery
echo "🐳 Scanning Docker containers..."
report "## Container Infrastructure"
report ""

if command -v docker &> /dev/null; then
    report "### Running Containers"
    report '```'
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" 2>/dev/null >> "$REPORT_FILE" || report "No Docker daemon or containers"
    report '```'
    report ""

    report "### Docker Images"
    report '```'
    docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | head -20 >> "$REPORT_FILE" 2>/dev/null || report "No Docker images"
    report '```'
    report ""
else
    report "⚠️ Docker not installed"
fi

# 4. Kubernetes Discovery (if applicable)
echo "☸️  Scanning Kubernetes clusters..."
report "## Kubernetes Resources"
report ""

if command -v kubectl &> /dev/null; then
    report "### Kubernetes Namespaces"
    report '```'
    kubectl get namespaces 2>/dev/null >> "$REPORT_FILE" || report "No Kubernetes cluster connected"
    report '```'
    report ""

    report "### Deployments (All Namespaces)"
    report '```'
    kubectl get deployments --all-namespaces 2>/dev/null | head -20 >> "$REPORT_FILE" || report "Unable to list deployments"
    report '```'
    report ""
else
    report "⚠️ kubectl not installed"
fi

# 5. Local Application Discovery
echo "💻 Scanning local applications..."
report "## Local Services & Applications"
report ""

report "### Listening Ports"
report '```'
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    lsof -iTCP -sTCP:LISTEN -P -n 2>/dev/null | head -20 >> "$REPORT_FILE" || report "Unable to scan ports"
else
    # Linux
    ss -tuln 2>/dev/null | head -20 >> "$REPORT_FILE" || report "Unable to scan ports"
fi
report '```'
report ""

# 6. Terraform State Discovery
echo "🏗️  Scanning Terraform configurations..."
report "## Infrastructure as Code"
report ""

report "### Terraform Files Found"
report '```'
find /Users/rsannicolas -name "*.tf" -type f 2>/dev/null | grep -v node_modules | head -20 >> "$REPORT_FILE" || report "No Terraform files found"
report '```'
report ""

# 7. Environment Analysis
echo "🔐 Scanning environment configuration..."
report "## Environment Configuration"
report ""

report "### Configured Services (from environment)"
report '```'
env | grep -E "(ENDPOINT|URL|HOST|API)" | grep -v TOKEN | grep -v KEY | grep -v PASSWORD | sort >> "$REPORT_FILE" || report "No service endpoints in environment"
report '```'
report ""

# 8. Package Dependencies
echo "📦 Scanning package dependencies..."
report "## Application Dependencies"
report ""

# Check for Node.js projects
if [[ -f "package.json" ]]; then
    report "### Node.js Dependencies"
    report '```'
    jq -r '.dependencies | to_entries[] | "\(.key): \(.value)"' package.json | head -20 >> "$REPORT_FILE" 2>/dev/null
    report '```'
    report ""
fi

# Check for Python projects
if [[ -f "requirements.txt" ]]; then
    report "### Python Dependencies"
    report '```'
    head -20 requirements.txt >> "$REPORT_FILE"
    report '```'
    report ""
fi

# 9. Generate Summary Statistics
echo "📊 Generating summary statistics..."
report "## Discovery Statistics"
report ""

# Count discovered items
GCP_COUNT=$(grep -c "RUNNING\|READY" "$REPORT_FILE" 2>/dev/null || echo 0)
GITHUB_COUNT=$(grep -c "github.com" "$REPORT_FILE" 2>/dev/null || echo 0)
DOCKER_COUNT=$(docker ps -q 2>/dev/null | wc -l || echo 0)

report "### Summary Counts"
report "- GCP Resources: ~$GCP_COUNT active"
report "- GitHub Repositories: ~$GITHUB_COUNT found"
report "- Docker Containers: $DOCKER_COUNT running"
report "- Discovery Timestamp: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
report ""

# 10. Risk Assessment
report "## Risk Assessment"
report ""
report "### Discovered Risks"
report ""

# Check for common issues
if grep -q "No description" "$REPORT_FILE"; then
    report "⚠️ **Undocumented Systems**: Found repositories without descriptions"
fi

if grep -q "0.0.0.0" "$REPORT_FILE"; then
    report "⚠️ **Public Bindings**: Services listening on all interfaces (0.0.0.0)"
fi

if grep -q "root" "$REPORT_FILE"; then
    report "⚠️ **Root Services**: Processes running as root user"
fi

report ""
report "### Recommended Actions"
report "1. Document all discovered systems in asset registry"
report "2. Review public-facing services for security"
report "3. Validate ownership of discovered resources"
report "4. Tag cloud resources with appropriate metadata"
report "5. Schedule deep-dive assessment for critical findings"
report ""

# 11. Export to JSON for processing
echo "💾 Exporting to JSON format..."
JSON_FILE="$OUTPUT_DIR/discovery_data_$TIMESTAMP.json"

cat > "$JSON_FILE" <<EOJSON
{
  "scan_timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "scan_type": "comprehensive",
  "summary": {
    "gcp_resources": $GCP_COUNT,
    "github_repos": $GITHUB_COUNT,
    "docker_containers": $DOCKER_COUNT
  },
  "report_location": "$REPORT_FILE"
}
EOJSON

# Final output
echo ""
echo "✅ Discovery scan complete!"
echo "📄 Report saved to: $REPORT_FILE"
echo "📊 JSON data saved to: $JSON_FILE"
echo ""
echo "Key findings:"
grep "⚠️" "$REPORT_FILE" | head -5 || echo "No critical findings"

# Open report if on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo ""
    echo "Opening report in default editor..."
    open "$REPORT_FILE" 2>/dev/null || cat "$REPORT_FILE"
else
    echo ""
    echo "View report with: cat $REPORT_FILE"
fi