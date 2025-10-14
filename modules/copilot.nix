{ ... }: {
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

      # Context configuration for repository awareness
      context = {
        __raw = ''
          function(bufnr, win_type)
            -- Get all files in the current working directory for chat context
            local cwd = vim.fn.getcwd()
            local files = {}
            
            -- Get files from git if in a git repo
            local git_files = vim.fn.systemlist("git ls-files 2>/dev/null")
            if vim.v.shell_error == 0 then
              for _, file in ipairs(git_files) do
                local full_path = cwd .. "/" .. file
                if vim.fn.filereadable(full_path) == 1 then
                  local ext = vim.fn.fnamemodify(file, ":e")
                  -- Include common source code file types and exclude binary/generated files
                  local skip_exts = { "png", "jpg", "jpeg", "gif", "ico", "svg", "webp", "mp4", "avi", "mov", "pdf", "zip", "tar", "gz", "exe", "dll", "so", "dylib", "class", "jar", "o", "obj", "pdb", "ilk", "exp", "lib", "a" }
                  local skip_patterns = { "%.min%.", "%.bundle%.", "%.chunk%.", "%.map$", "%-lock%.", "%.lock$" }
                  local skip_dirs = { "node_modules/", ".git/", "build/", "dist/", "target/", ".cache/", ".next/", ".nuxt/", "coverage/", ".nyc_output/", "vendor/" }
                  
                  -- Skip binary files and common build artifacts
                  local should_skip = false
                  for _, skip_ext in ipairs(skip_exts) do
                    if ext == skip_ext then
                      should_skip = true
                      break
                    end
                  end
                  
                  if not should_skip then
                    for _, pattern in ipairs(skip_patterns) do
                      if file:match(pattern) then
                        should_skip = true
                        break
                      end
                    end
                  end
                  
                  if not should_skip then
                    for _, skip_dir in ipairs(skip_dirs) do
                      if file:match("^" .. skip_dir) then
                        should_skip = true
                        break
                      end
                    end
                  end
                  
                  if not should_skip and #files < 100 then -- Limit to 100 files for performance
                    table.insert(files, full_path)
                  end
                end
              end
            else
              -- Fallback to find if not in git repo - include common source file patterns
              local find_patterns = {
                "*.js", "*.ts", "*.jsx", "*.tsx", "*.py", "*.go", "*.rs", "*.java", "*.c", "*.cpp", "*.h", "*.hpp",
                "*.rb", "*.php", "*.swift", "*.kt", "*.scala", "*.clj", "*.hs", "*.ml", "*.ex", "*.exs",
                "*.sh", "*.bash", "*.zsh", "*.fish", "*.ps1", "*.bat", "*.cmd",
                "*.html", "*.css", "*.scss", "*.sass", "*.less", "*.vue", "*.svelte",
                "*.json", "*.yaml", "*.yml", "*.toml", "*.xml", "*.ini", "*.cfg", "*.conf",
                "*.md", "*.rst", "*.txt", "*.org", "*.tex",
                "*.sql", "*.graphql", "*.proto", "*.thrift",
                "*.nix", "*.lua", "*.vim", "*.vimrc", "*.tmux.conf",
                "Makefile", "Dockerfile", "Jenkinsfile", "Vagrantfile", "Gemfile", "Podfile",
                "*.gradle", "*.maven", "*.sbt", "build.gradle", "pom.xml", "package.json", "Cargo.toml", "go.mod",
                "flake.*", "justfile", "README*", "LICENSE*", "CHANGELOG*", "CONTRIBUTING*"
              }
              
              local find_cmd = "find " .. cwd .. " \\( -name node_modules -o -name .git -o -name build -o -name dist -o -name target \\) -prune -o -type f \\( "
              for i, pattern in ipairs(find_patterns) do
                if i > 1 then find_cmd = find_cmd .. " -o " end
                find_cmd = find_cmd .. "-name '" .. pattern .. "'"
              end
              find_cmd = find_cmd .. " \\) -print 2>/dev/null | head -100"
              
              local find_files = vim.fn.systemlist(find_cmd)
              for _, file in ipairs(find_files) do
                if vim.fn.filereadable(file) == 1 then
                  table.insert(files, file)
                end
              end
            end
            
            return files
          end
        '';
      };

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

      # File inclusion patterns for repository scanning
      prompts = {
        Explain = {
          prompt =
            "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.";
        };
        Review = { prompt = "/COPILOT_REVIEW Review the selected code."; };
        Fix = {
          prompt =
            "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.";
        };
        Optimize = {
          prompt =
            "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.";
        };
        Docs = {
          prompt =
            "/COPILOT_GENERATE Please add documentation comment for the selection.";
        };
        Tests = {
          prompt = "/COPILOT_GENERATE Please generate tests for my code.";
        };
        FixDiagnostic = {
          prompt = "Please assist with the following diagnostic issue in file";
          selection = "diagnostics";
        };
        Commit = {
          prompt =
            "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit and write the body of the message as a list.";
          selection = "gitdiff";
        };
        CommitStaged = {
          prompt =
            "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit and write the body of the message as a list.";
          selection = "gitdiff";
        };
      };

      # Keymaps
      mappings = {
        complete = { insert = "<Tab>"; };
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
        show_diff = { normal = "gd"; };
        show_info = { normal = "gi"; };
        show_context = { normal = "gc"; };
        yank_diff = {
          normal = "gy";
          register = ''"'';
        };
      };
    };
  };
}
