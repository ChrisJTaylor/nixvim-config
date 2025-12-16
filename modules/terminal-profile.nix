# Terminal-optimized profile configuration
# This module contains settings optimized for terminal-only environments
{ ... }: {
  imports = [
    ./clipboard-ssh.nix
    ./tmux-integration.nix
  ];

  colorschemes.cyberdream.settings = {
    # Disable transparency for better terminal compatibility
    transparent = false;
  };

  # No transparency effects in terminal mode for better readability
  # winblend and pumblend are omitted (default to 0)
}
