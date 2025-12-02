{ pkgs, ... }: {
  plugins.treesitter = {
    enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      json
      lua
      make
      markdown
      regex
      toml
      vim
      vimdoc
      xml
      javascript
      typescript
      tsx
      java
      kotlin
      rust
      go
      zig
      asm
      c
      cpp
      python
      objc
      ruby
    ];

    folding = false;
    nixvimInjections = true;
    nixGrammars = true;
    settings = {
      ensure_installed = [ ];
      auto_install = false;
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
    enable = true;
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

  plugins.web-devicons.enable = true;
}
