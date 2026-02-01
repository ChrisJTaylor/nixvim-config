{...}: {
  plugins.blink-copilot.enable = true;
  plugins.blink-ripgrep.enable = false;
  plugins.blink-cmp-git.enable = true;
  plugins.blink-cmp-dictionary.enable = true;
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
          auto_show_delay_ms = 100;
          treesitter_highlighting = true;
        };
        ghost_text.enabled = true;
        menu = {
          enabled = true;
          auto_show = true;
        };
        # Speed optimizations
        trigger = {
          show_on_insert_on_trigger_character = true;
        };
        list = {
          max_items = 200;
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
        "<Tab>" = [
          "select_next"
          "snippet_forward"
          "fallback"
        ];
        "<S-Tab>" = [
          "select_prev"
          "snippet_backward"
          "fallback"
        ];
        "<CR>" = [
          "select_and_accept"
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
          "git"
          "dictionary"
        ];
        min_keyword_length = 1;
        providers = {
          lsp = {
            async = true;
            name = "LSP";
            fallbacks = ["buffer"];
            score_offset = 1000;
            min_keyword_length = 0;
            # Speed optimizations for LSP completions
            timeout_ms = 200;
            should_show_items = true;
          };
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
              search_casing = "--ignore-case";
              additional_rg_options = [];
              fallback_to_regex_highlighting = true;
            };
          };
          copilot = {
            async = true;
            module = "blink-copilot";
            name = "copilot";
            score_offset = 50;
            timeout_ms = 1000;
            opts = {
              max_completions = 20;
              max_attempts = 4;
              kind = "Copilot";
              debounce = 150;
              auto_refresh = {
                backward = true;
                forward = true;
              };
            };
          };
          git = {
            module = "blink-cmp-git";
            name = "git";
            score_offset = 75;
            opts = {
              commit = {};
              git_centers = {git_hub = {};};
            };
          };
          dictionary = {
            module = "blink-cmp-dictionary";
            name = "Dict";
            score_offset = 100;
            min_keyword_length = 3;
            # Optional configurations
            opts = {};
          };
        };
      };
    };
  };
}
