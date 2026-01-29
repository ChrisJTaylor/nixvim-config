{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;

    folding.enable = false;
    nixvimInjections = true;
    nixGrammars = true;
    settings = {
      ensure_installed = [];
      auto_install = false;
      highlight = {
        enable = true;
      };
      indent = {
        enable = true;
      };
    };
  };

  plugins.treesitter-context = {
    enable = true;
    settings = {
      enable = true;
      mode = "topline";
      line_numbers = true;
    };
  };

  plugins.treesitter-refactor = {
    enable = false;
    settings = {
      highlight_current_scope.enable = true;
      highlight_definitions = {
        enable = true;
        clear_on_cursor_move = true;
      };
      navigation.enable = true;
      smart_rename.enable = true;
    };
  };

  plugins.refactoring.enable = true;
  plugins.refactoring.enableTelescope = true;
}
