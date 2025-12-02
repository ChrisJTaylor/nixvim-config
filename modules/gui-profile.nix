# GUI-optimized profile configuration
# This module contains settings optimized for GUI environments with transparency effects
{ ... }: {
  colorschemes.cyberdream.settings = {
    # Enhanced transparency for GUI environments
    transparent = true;
  };

  opts = {
    # Space-age transparency effects for GUI
    winblend = 15; # Transparent floating windows
    pumblend = 15; # Transparent popups
  };
}
