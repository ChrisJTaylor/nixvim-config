#!/usr/bin/env bash

echo "Testing CopilotChat setup..."
echo "============================="

echo "1. Building nixvim configuration..."
nix build

if [ $? -eq 0 ]; then
    echo "✅ Build successful"
else
    echo "❌ Build failed"
    exit 1
fi

echo ""
echo "2. Creating test environment..."
cd /tmp
mkdir -p copilot-test
cd copilot-test

# Initialize a git repo
git init

# Create some test files
echo "console.log('Hello World');" > app.js
echo "def hello(): return 'Hello World'" > app.py
echo "package main; import \"fmt\"; func main() { fmt.Println(\"Hello World\") }" > app.go
echo "# Test Project" > README.md

# Stage files
git add .
git config user.email "test@example.com"
git config user.name "Test User"
git commit -m "Initial commit"

echo "✅ Test repository created with sample files"

echo ""
echo "3. Testing CopilotChat commands..."
echo ""
echo "You can now test the CopilotChat functionality:"
echo ""
echo "Start neovim with: ./result/bin/nvim ."
echo "This should automatically open CopilotChat with full codebase context!"
echo ""
echo "Available commands:"
echo "  :CopilotChat          - Open chat"
echo "  :CopilotChatContext   - Show context info"  
echo "  :CopilotChatOpen      - Open with full context message"
echo "  :CopilotRefresh       - Refresh workspace"
echo ""
echo "Available keymaps:"
echo "  <leader>cc  - Open CopilotChat"
echo "  <leader>ca  - Open CopilotChat with context message"
echo "  <leader>ci  - Show context information"
echo "  <leader>ce  - Explain selection"
echo "  <leader>cf  - Fix selection"
echo "  <leader>cr  - Review code"
echo ""
echo "The configuration will automatically:"
echo "  - Index all git-tracked files in the repository"
echo "  - Provide them as context to CopilotChat"
echo "  - Show debug messages about what files are being indexed"
echo ""
