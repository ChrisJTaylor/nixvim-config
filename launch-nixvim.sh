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
    echo "💻 Launching Terminal-optimized NixVim (no transparency)..."
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
  "help"|"-h"|"--help")
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  gui, (default)    Launch GUI-optimized NixVim with transparency"
    echo "  terminal, term    Launch Terminal-optimized NixVim without transparency"
    echo "  build-gui         Build GUI profile"
    echo "  build-terminal    Build Terminal profile"
    echo "  help              Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                # Launch GUI profile"
    echo "  $0 terminal       # Launch terminal profile"
    echo "  $0 build-gui      # Build GUI profile"
    ;;
  *)
    echo "❌ Unknown command: $1"
    echo "Use '$0 help' to see available commands"
    exit 1
    ;;
esac