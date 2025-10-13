{...}: {
  plugins.copilot-lua = {
    enable = true;
    settings = {
      suggestion = {
        enabled = false;  # Keep disabled to avoid intrusive completions
        auto_trigger = false;
        debounce = 75;
        keymap = {
          accept = "<M-l>";
          accept_word = false;
          accept_line = false;
          next = "<M-]>";
          prev = "<M-[>";
          dismiss = "<C-]>";
        };
      };
      panel.enabled = false;
      
      # Add workspace configuration for better context
      copilot_node_command = "node";
      server_opts_overrides = {
        trace = "verbose";
        settings = {
          advanced = {
            listCount = 10;
            inlineSuggestCount = 3;
          };
        };
      };
    };
  };

  plugins.copilot-chat = {
    enable = true;

    settings = {
      accept_diff = {
        insert = "<C-y>";
        normal = "<C-y>";
      };
      close = {
        insert = "<ESC>";
        normal = "q";
      };
      complete = {
        insert = "<Tab>";
      };
      jump_to_diff = {
        normal = "gj";
      };
      quickfix_diffs = {
        normal = "gq";
      };
      reset = {
        insert = "<C-l>";
        normal = "<C-l>";
      };
      show_context = {
        normal = "gc";
      };
      show_diff = {
        normal = "gd";
      };
      show_info = {
        normal = "gi";
      };
      submit_prompt = {
        insert = "<C-s>";
        normal = "<CR>";
      };
      toggle_sticky = {
        detail = "Makes line under cursor sticky or deletes sticky line.";
        normal = "gr";
      };
      yank_diff = {
        normal = "gy";
        register = "\"";
      };
    };
  };
}
