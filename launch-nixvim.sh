#!/usr/bin/env bash
# NixVim Profile Launcher
# This script provides easy access to different nixvim profiles

set -e

case "${1:-}" in
  "gui"|"")
    echo "🎨 Launching GUI-optimized NixVim (with transparency effects)..."
    nix run .
    ;;
  "terminal"|"term")
    echo "💻 Launching Terminal-optimized NixVim (OSC 52 clipboard support)..."
    nix run .#terminal
    ;;
  "build-gui")
    echo "🔨 Building GUI profile..."
    nix build .
    ;;
  "build-terminal")
    echo "🔨 Building Terminal profile..."
    nix build .#terminal
    ;;
  "test-clipboard")
    echo "📋 Testing clipboard functionality..."
    echo "Creating test file..."
    echo "Hello from server nixvim!" > /tmp/clipboard-test.txt
    echo "Copying to clipboard via OSC 52..."
    nix run .#terminal -- --headless -c 'edit /tmp/clipboard-test.txt' -c 'normal! ggVG"+y' -c 'echo "✓ Copied to clipboard!"' -c 'quit'
    echo "Check your local clipboard - it should contain: 'Hello from server nixvim!'"
    ;;
  "clipboard-status")
    echo "📋 Checking clipboard configuration..."
    nix run .#terminal -- --headless -c 'ClipboardStatus' -c 'quit'
    ;;
  "help"|"-h"|"--help")
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  gui, (default)      Launch GUI-optimized NixVim with transparency"
    echo "  terminal, term      Launch Terminal-optimized NixVim with OSC 52 clipboard"
    echo "  build-gui           Build GUI profile"
    echo "  build-terminal      Build Terminal profile"
    echo "  test-clipboard      Test SSH clipboard functionality (OSC 52)"
    echo "  clipboard-status    Show clipboard configuration status"
    echo "  help                Show this help message"
    echo ""
    echo "SSH Clipboard Setup:"
    echo "  ✓ Automatic tmux configuration included in nixvim"
    echo "  ✓ OSC 52 support for Ghostty, Windows Terminal, iTerm2, etc."
    echo "  ✓ No manual configuration required!"
    echo ""
    echo "Supported Terminals:"
    echo "  ✓ Ghostty (recommended) - works out of the box"
    echo "  ✓ Windows Terminal - works with focus"
    echo "  ✓ iTerm2, Kitty, Alacritty - check terminal settings"
    echo ""
    echo "Features:"
    echo "  ✓ Automatic tmux configuration for OSC 52"
    echo "  ✓ tmux-navigator plugin for seamless pane navigation"
    echo "  ✓ Environment detection and auto-setup"
    echo ""
    echo "Examples:"
    echo "  $0                    # Launch GUI profile"
    echo "  $0 terminal          # Launch terminal profile with SSH clipboard"
    echo "  $0 test-clipboard    # Test clipboard functionality"
    ;;
  *)
    echo "❌ Unknown command: $1"
    echo "Use '$0 help' to see available commands"
    exit 1
    ;;
esac