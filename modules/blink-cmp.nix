{...}: {
  plugins.blink-copilot.enable = true;
  plugins.blink-ripgrep.enable = true;
  plugins.blink-cmp-git.enable = true;
  plugins.blink-compat = {
    enable = true;
    settings = {
      impersonate_nvim_cmp = true;
    };
  };

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
        "<C-CR>" = [
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
          "snippets"
          "buffer"
          "path"
          "copilot"
          "ripgrep"
          "git"
        ];
        providers = {
          ripgrep = {
            async = true;
            module = "blink-ripgrep";
            name = "Ripgrep";
            score_offset = 100;
            opts = {
              prefix_min_len = 3;
              context_size = 5;
              max_filesize = "1M";
              project_root_marker = ".git";
              project_root_fallback = true;
              search_casing = "--ignore-case";
              additional_rg_options = {};
              fallback_to_regex_highlighting = true;
              ignore_paths = {};
              additional_paths = {};
              debug = false;
            };
          };
          copilot = {
            async = true;
            module = "blink-copilot";
            name = "copilot";
            score_offset = 100;
            opts = {
              max_completions = 20;
              max_attempts = 4;
              kind = "Copilot";
              debounce = 750;
              auto_refresh = {
                backward = true;
                forward = true;
              };
            };
          };
          git = {
            module = "blink-cmp-git";
            name = "git";
            score_offset = 100;
            opts = {
              commit = {};
              git_centers = {git_hub = {};};
            };
          };
        };
      };
    };
  };
}
