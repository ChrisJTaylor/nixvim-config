{...}: {
  plugins.blink-copilot.enable = true;

  plugins.blink-cmp = {
    enable = true;

    settings = {
      completion = {
        accept = {
          create_undo_point = true;
          auto_brackets = {
            enabled = true;
          };
        };
        documentation = {
          auto_show = true;
          treesitter_highlighting = true;
        };
        ghost_text.enabled = true;
        menu = {
          enabled = true;
          auto_show = true;
        };
      };

      keymap = {
        "<C-f>" = [
          "scroll_documentation_up"
          "fallback"
        ];
        "<C-e>" = [
          "hide"
        ];
        "<C-b>" = [
          "scroll_documentation_down"
          "fallback"
        ];
        "<C-n>" = [
          "select_next"
          "fallback"
        ];
        "<C-p>" = [
          "select_prev"
          "fallback"
        ];
        "<C-space>" = [
          "show"
          "show_documentation"
          "hide_documentation"
        ];
        "<Enter>" = [
          "select_and_accept"
        ];
        "<Down>" = [
          "select_next"
          "fallback"
        ];
        "<S-Tab>" = [
          "snippet_backward"
          "fallback"
        ];
        "<Tab>" = [
          "snippet_forward"
          "fallback"
        ];
        "<Up>" = [
          "select_prev"
          "fallback"
        ];
      };

      sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
          "copilot"
        ];
        providers = {
          copilot = {
            async = true;
            module = "blink-copilot";
            name = "copilot";
            score_offset = 100;
            opts = {
              max_completions = 5;
              max_attempts = 4;
              kind = "Copilot";
              debounce = 750;
              auto_refresh = {
                backward = true;
                forward = true;
              };
            };
          };
        };
      };
    };
  };
}
