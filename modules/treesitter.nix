{pkgs, ...}: {
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
      yaml
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
      swift
      objc
      ruby
    ];

    folding = true;
    nixvimInjections = true;
    nixGrammars = true;
    settings = {
      ensure_installed = "all";
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
    highlightCurrentScope.enable = true;
    highlightDefinitions = {
      enable = true;
      clearOnCursorMove = true;
    };
    navigation.enable = true;
    smartRename.enable = true;
  };

  plugins.refactoring.enable = true;
  plugins.refactoring.enableTelescope = true;

  plugins.web-devicons.enable = true;
}
