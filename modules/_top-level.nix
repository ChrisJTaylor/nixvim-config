{ pkgs, ... }: {
  # Clipboard configuration moved to profile-specific modules:
  # - GUI profile: ./clipboard-gui.nix (xclip/wl-clipboard)
  # - Terminal profile: ./clipboard-ssh.nix (OSC 52)

  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    # Clipboard setting moved to profile-specific modules
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

  plugins.numbertoggle.enable = true;
  plugins.precognition.enable = false;
  plugins.which-key.enable = true;
  editorconfig.enable = true;
  plugins.nix.enable = true;
  plugins.nix-develop.enable = true;
  plugins.rainbow-delimiters.enable = true;
  plugins.twilight.enable = true;

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
