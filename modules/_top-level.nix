{ ... }: {
  colorschemes = {
    tokyonight = {
      enable = true;
      settings = {
        style = "moon";
        transparent = false;
        styles = {
          comments = {
            italic = true;
            bg = "#90FE13";
            fg = "#FD12DD";
          };
          sidebars = "dark";
          floats = "dark";
        };
      };
    };
    cyberdream = {
      enable = false;
      settings = {
        borderless_telescope = true;
        hide_fillchars = true;
        italic_comments = true;
        terminal_colors = true;
        editorconfig.enable = true;
        theme = {
          colors = {
            # bg = "#000000";
            # bg_alt = "#44F24F";
            # bg_highlight = "#ff5ef1";
            # grey = "#0D0D0D";
            # fg = "#ffffff";
            # blue = "#34BF49";
            # green = "#44F24F";
            # cyan = "#44F24F";
            # red = "#01260A";
            # yellow = "#44F24F";
            # magenta = "#ff5ef1";
            # pink = "#ff5ea0";
            # orange = "#12732A";
            orange = "#44F24F";
            # purple = "#bd5eff";
          };
          highlights = {
            Comment = {
              bg = "#01260A";
              fg = "#12732A";
            };
          };
          transparent = true;
        };
      };
    };
  };

  clipboard.providers.xclip.enable = true;

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
  };

  plugins.snacks = {
    enable = true;
    settings = {
      bigfile = {
        enabled = true;
      };
      notifier = {
        enabled = true;
        timeout = 3000;
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
}
