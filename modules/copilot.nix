{...}: {
  plugins.copilot-lua = {
    enable = true;
    settings = {
      suggestion = {
        enabled = false; # Keep disabled to avoid intrusive completions
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

      # Window configuration
      window = {
        layout = "vertical";
        width = 0.4; # 40% of screen width
      };

      # Auto-insert mode when opening chat
      auto_insert_mode = true;

      # Show help actions in chat
      show_help = true;

      # Automatically include git information
      auto_follow_cursor = false;

      # Enhanced prompts with resource syntax for better context
      prompts = {
        Explain = {
          prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.";
        };
        Review = {prompt = "/COPILOT_REVIEW Review the selected code.";};
        Fix = {
          prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.";
        };
        Optimize = {
          prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.";
        };
        Docs = {
          prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.";
        };
        Tests = {
          prompt = "/COPILOT_GENERATE Please generate tests for my code.";
        };
        FixDiagnostic = {
          prompt = "Please assist with the following diagnostic issue in file";
          selection = "diagnostics";
        };
        Commit = {
          prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit and write the body of the message as a list.";
          selection = "gitdiff";
        };
        CommitStaged = {
          prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit and write the body of the message as a list.";
          selection = "gitdiff";
        };
        # New prompts that showcase resource usage for any project type
        ProjectOverview = {
          prompt = "#glob:**/* #glob:**/*.md #glob:**/*.txt #glob:**/*.json Please provide an overview of this project, including its structure, main features, and technology stack.";
        };
        CodeAnalysis = {
          prompt = "#glob:**/* Analyze this codebase and suggest improvements, optimizations, or best practices based on the programming languages used.";
        };
        ProjectHelp = {
          prompt = "#buffer:active #glob:**/* Help me understand this code and how it fits into the overall project structure and architecture.";
        };
      };

      # Keymaps
      mappings = {
        complete = {insert = "<Tab>";};
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
        show_diff = {normal = "gd";};
        show_info = {normal = "gi";};
        show_context = {normal = "gc";};
        yank_diff = {
          normal = "gy";
          register = ''"'';
        };
      };
    };
  };
}
