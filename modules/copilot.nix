{...}: {
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

  plugins.copilot-lua = {
    settings = {
      panel = {
        keymap = {
          next = "<M-j>";
          previous = "<M-k>";
          accept = "<M-CR>";
          close = "<M-ESC>";
        };
      };
      suggestion = {
        keymap = {
          next = "<M-j>";
          previous = "<M-k>";
          accept = "<M-CR>";
          close = "<M-ESC>";
        };
      };
    };
  };
}
