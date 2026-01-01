{pkgs, ...}: {
  colorschemes = {
    tokyonight = {
      enable = false;
    };
    cyberdream = {
      enable = true;
      settings = {
        # Enhanced space-age configuration
        # Profile-specific transparency settings are handled in gui-profile.nix / terminal-profile.nix
        borderless_telescope = true;
        hide_fillchars = true;
        italic_comments = true;
        terminal_colors = true;

        # Space-age color palette
        colors = {
          # Deep space backgrounds
          bg = "#0a0a0a";
          bg_alt = "#111111";
          bg_highlight = "#4e4e4e";

          # Enhanced neon colors for space-age vibes
          cyan = "#5ef1ff";
          magenta = "#ff5ef1";
          blue = "#5ea1ff";
          green = "#5eff6c";
          purple = "#bd5eff";
          yellow = "#f1ff5e";
          orange = "#ffbd5e";
          pink = "#ff5ea0";
          red = "#ff6e5e";
        };

        # Enhanced highlights with your comment requirements
        highlights = {
          # Your specific requirement: purple comments with bright green background
          Comment = {
            fg = "#bd5eff"; # Purple text
            bg = "#5eff6c"; # Green background
          };

          # Enhanced space-age highlights
          Normal = {
            bg = "#0a0a0a";
          };

          # Make floating windows more space-age
          NormalFloat = {
            bg = "#111111";
          };

          # Enhance visual elements
          CursorLine = {
            bg = "#1a1a1a";
          };

          # Make selection more vibrant
          Visual = {
            bg = "#ff5ef1";
            fg = "#0a0a0a";
          };
        };
      };
    };
  };
}
