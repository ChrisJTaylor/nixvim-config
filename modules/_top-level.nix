{ pkgs, ... }: {
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
          bg_highlight = "#1a1a1a";

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
            fg = "#6f1daa"; # Purple text
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

  clipboard.providers = {
    xclip.enable = pkgs.stdenv.isLinux;
  };

  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    clipboard = "unnamedplus";
    undofile = true;
    ignorecase = true;
    smartcase = true;
    timeoutlen = 300;
    splitright = true;
    splitbelow = true;
    scrolloff = 10;
    hlsearch = true;
    termguicolors = true;
    background = "dark";
    # Profile-specific transparency settings (winblend/pumblend) are handled in profile modules
  };

  # Simplified snacks configuration - disable dashboard to fix lazy.stats error
  plugins.snacks = {
    enable = true;
    settings = {
      bigfile = {
        enabled = true;
      };
      notifier = {
        enabled = false; # Keep disabled to avoid conflicts
      };
      quickfile = {
        enabled = false;
      };
      statuscolumn = {
        enabled = true;
      };
      words = {
        debounce = 100;
        enabled = true;
      };
      dashboard = {
        enabled = false; # Disable to fix lazy.stats error
      };
    };
  };

  plugins.precognition.enable = false;
  plugins.which-key.enable = true;
  editorconfig.enable = true;
  plugins.nix.enable = true;
  plugins.nix-develop.enable = true;
  plugins.rainbow-delimiters.enable = true;

  plugins.undotree = {
    enable = true;
    settings = {
      CursorLine = true;
      DiffAutoOpen = true;
      DiffCommand = "diff";
      DiffpanelHeight = 10;
      HelpLine = true;
      HighlightChangedText = true;
      HighlightChangedWithSign = true;
      HighlightSyntaxAdd = "DiffAdd";
      HighlightSyntaxChange = "DiffChange";
      HighlightSyntaxDel = "DiffDelete";
      RelativeTimestamp = true;
      SetFocusWhenToggle = true;
      ShortIndicators = false;
      SplitWidth = 40;
      TreeNodeShape = "*";
      TreeReturnShape = "\\";
      TreeSplitShape = "/";
      TreeVertShape = "|";
      WindowLayout = 4;
    };
  };

  # Enhanced Alpha dashboard with animated neon title  
  plugins.alpha = {
    enable = true;
    settings = {
      layout = [
        {
          type = "padding";
          val = 2;
        }
        {
          type = "text";
          val = [
            "        ███╗   ███╗ █████╗  ██████╗██╗  ██╗██╗███╗   ██╗ ██████╗ ██╗      ██████╗  ██████╗██╗   ██╗        "
            "        ████╗ ████║██╔══██╗██╔════╝██║  ██║██║████╗  ██║██╔═══██╗██║     ██╔═══██╗██╔════╝╚██╗ ██╔╝        "
            "        ██╔████╔██║███████║██║     ███████║██║██╔██╗ ██║██║   ██║██║     ██║   ██║██║  ███╗╚████╔╝         "
            "        ██║╚██╔╝██║██╔══██║██║     ██╔══██║██║██║╚██╗██║██║   ██║██║     ██║   ██║██║   ██║ ╚██╔╝          "
            "        ██║ ╚═╝ ██║██║  ██║╚██████╗██║  ██║██║██║ ╚████║╚██████╔╝███████╗╚██████╔╝╚██████╔╝  ██║           "
            "        ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝   ╚═╝           "
            "                                                                                                           "
            "                        ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗                               "
            "                        ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║                               "
            "                        ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║                               "
            "                        ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║                               "
            "                        ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║                               "
            "                        ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                               "
          ];
          opts = {
            position = "center";
            hl = "Function"; # Use Function highlight for space-age cyan color
          };
        }
        {
          type = "padding";
          val = 2;
        }
        {
          type = "group";
          val = [
            {
              type = "button";
              val = "  New File";
              on_press.__raw = "function() vim.cmd('enew') end";
              opts = {
                shortcut = "n";
                position = "center";
                cursor = 3;
                width = 50;
                align_shortcut = "right";
                hl_shortcut = "Keyword";
              };
            }
            {
              type = "button";
              val = "  Find File";
              on_press.__raw = "function() require('telescope.builtin').find_files() end";
              opts = {
                shortcut = "f";
                position = "center";
                cursor = 3;
                width = 50;
                align_shortcut = "right";
                hl_shortcut = "Keyword";
              };
            }
            {
              type = "button";
              val = "  Recent Files";
              on_press.__raw = "function() require('telescope.builtin').oldfiles() end";
              opts = {
                shortcut = "r";
                position = "center";
                cursor = 3;
                width = 50;
                align_shortcut = "right";
                hl_shortcut = "Keyword";
              };
            }
            {
              type = "button";
              val = "  Quit";
              on_press.__raw = "function() vim.cmd('qa') end";
              opts = {
                shortcut = "q";
                position = "center";
                cursor = 3;
                width = 50;
                align_shortcut = "right";
                hl_shortcut = "Keyword";
              };
            }
          ];
          opts = {
            spacing = 1;
          };
        }
        {
          type = "padding";
          val = 2;
        }
      ];
    };
  };
  plugins.noice.enable = false;
  plugins.notify.enable = false;

  # Add indent guides for clean tech look
  plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "▏"; # Thin, minimal lines for that clean tech look
      };
      scope = {
        char = "▎"; # Slightly thicker for scope
        highlight = "Function";
      };
    };
  };
}
