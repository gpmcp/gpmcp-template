#!/bin/bash
# Quick setup script for customizing the template

set -e

echo "🦀 Rust Workspace Template Setup"
echo "================================"
echo

# Get project name
read -p "Enter your project name (lowercase, e.g., 'myproject'): " NEW_NAME

if [ -z "$NEW_NAME" ]; then
  echo "Error: Project name cannot be empty"
  exit 1
fi

# Get organization name
read -p "Enter your GitHub organization/username: " ORG_NAME

if [ -z "$ORG_NAME" ]; then
  echo "Error: Organization name cannot be empty"
  exit 1
fi

# Get repository name
read -p "Enter your repository name (or press Enter to use project name): " REPO_NAME
REPO_NAME=${REPO_NAME:-$NEW_NAME}

echo
echo "Configuration:"
echo "  Project: $NEW_NAME"
echo "  Org: $ORG_NAME"
echo "  Repo: $REPO_NAME"
echo
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 1
fi

echo
echo "🔧 Applying changes..."

# Replace in Cargo.toml files
echo "  → Updating Cargo.toml files..."
find . -name "Cargo.toml" -type f -exec sed -i.bak "s/project_/${NEW_NAME}_/g" {} \;
find . -name "Cargo.toml" -type f -exec sed -i.bak "s/project-cli/${NEW_NAME}-cli/g" {} \;

# Replace in Rust files
echo "  → Updating Rust files..."
find . -name "*.rs" -type f -exec sed -i.bak "s/project_/${NEW_NAME}_/g" {} \;
find . -name "*.rs" -type f -exec sed -i.bak "s/project-cli/${NEW_NAME}-cli/g" {} \;

# Replace in sonar-project.properties
echo "  → Updating sonar-project.properties..."
sed -i.bak "s/YOUR_ORG/${ORG_NAME}/g" sonar-project.properties
sed -i.bak "s/YOUR_PROJECT_KEY/${ORG_NAME}_${REPO_NAME}/g" sonar-project.properties

# Clean up backup files
echo "  → Cleaning up..."
find . -name "*.bak" -type f -delete

echo
echo "✅ Setup complete!"
echo
echo "Next steps:"
echo "  1. Review the changes: git diff"
echo "  2. Build the project: cargo build"
echo "  3. Run tests: cargo test"
echo "  4. Generate CI workflows: cargo test -p ${NEW_NAME}_ci"
echo
echo "See TEMPLATE_USAGE.md for more information."
