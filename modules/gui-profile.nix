# GUI-optimized profile configuration
# This module contains settings optimized for GUI environments with transparency effects
{ ... }: {
  imports = [
    ./clipboard-gui.nix
  ];

  colorschemes.everforest.settings = {
    # Enhanced transparency for GUI environments
    transparent_background = 1;
  };

  opts = {
    # Space-age transparency effects for GUI
    winblend = 15; # Transparent floating windows
    pumblend = 15; # Transparent popups
  };
}
