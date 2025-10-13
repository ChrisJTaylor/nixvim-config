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
      # Model configuration for better context understanding
      model = "gpt-4o";
      
      # Context configuration for repository awareness
      context = "buffers";  # Include all open buffers for context
      
      # Window configuration
      window = {
        layout = "float";
        relative = "cursor";
        width = 0.8;
        height = 0.6;
        row = 1;
      };
      
      # Auto-insert mode when opening chat
      auto_insert_mode = true;
      
      # Show help actions in chat
      show_help = true;
      
      # Automatically include git information
      auto_follow_cursor = false;
      
      # Keymaps
      mappings = {
        complete = {
          insert = "<Tab>";
        };
        close = {
          insert = "<ESC>";
          normal = "q";
        };
        reset = {
          insert = "<C-l>";
          normal = "<C-l>";
        };
        submit_prompt = {
          insert = "<C-s>";
          normal = "<CR>";
        };
        accept_diff = {
          insert = "<C-y>";
          normal = "<C-y>";
        };
        show_diff = {
          normal = "gd";
        };
        show_info = {
          normal = "gi";
        };
        show_context = {
          normal = "gc";
        };
        yank_diff = {
          normal = "gy";
          register = "\"";
        };
      };
    };
  };
}
