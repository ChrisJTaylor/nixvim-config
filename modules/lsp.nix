{pkgs, ...}: {
  # Configure inline diagnostic messages (virtual text with multi-line support)
  extraConfigLua = ''
    -- Helper function to split long messages into multiple lines
    local function split_message(message, max_width)
      if #message <= max_width then
        return {message}
      end

      local lines = {}
      local current_line = ""

      for word in message:gmatch("%S+") do
        -- Handle words longer than max_width by splitting them
        if #word > max_width then
          -- Flush current line first
          if current_line ~= "" then
            table.insert(lines, current_line)
            current_line = ""
          end

          -- Split the long word into chunks
          while #word > max_width do
            table.insert(lines, word:sub(1, max_width))
            word = word:sub(max_width + 1)
          end

          -- Add remaining part of word
          if #word > 0 then
            current_line = word
          end
        elseif #current_line + #word + 1 <= max_width then
          current_line = current_line == "" and word or current_line .. " " .. word
        else
          if current_line ~= "" then
            table.insert(lines, current_line)
          end
          current_line = word
        end
      end

      if current_line ~= "" then
        table.insert(lines, current_line)
      end

      -- Limit to 3 lines to avoid screen clutter
      if #lines > 3 then
        lines = {lines[1], lines[2], lines[3] .. "..."}
      end

      return lines
    end

    -- Custom diagnostic handler for multi-line virtual text
    local ns = vim.api.nvim_create_namespace("custom_diagnostics")
    local updating = false  -- Guard flag to prevent recursion

    local function show_diagnostics(bufnr)
      -- Prevent recursive calls
      if updating then
        return
      end

      updating = true

      -- Clear previous custom diagnostics
      pcall(vim.api.nvim_buf_clear_namespace, bufnr, ns, 0, -1)

      local diagnostics = vim.diagnostic.get(bufnr)
      for _, diagnostic in ipairs(diagnostics) do
        local lines = split_message(diagnostic.message, 80)

        if #lines == 1 then
          -- Single line: use standard virtual_text
          pcall(vim.api.nvim_buf_set_extmark, bufnr, ns, diagnostic.lnum, 0, {
            virt_text = {{" ● " .. lines[1], "DiagnosticVirtualText" .. vim.diagnostic.severity[diagnostic.severity]}},
            virt_text_pos = "eol",
          })
        else
          -- Multi-line: use virt_lines for continuation
          local virt_lines = {}
          for i, line in ipairs(lines) do
            if i == 1 then
              -- First line at end of code line
              pcall(vim.api.nvim_buf_set_extmark, bufnr, ns, diagnostic.lnum, 0, {
                virt_text = {{" ● " .. line, "DiagnosticVirtualText" .. vim.diagnostic.severity[diagnostic.severity]}},
                virt_text_pos = "eol",
              })
            else
              -- Continuation lines below
              table.insert(virt_lines, {{"   " .. line, "DiagnosticVirtualText" .. vim.diagnostic.severity[diagnostic.severity]}})
            end
          end

          if #virt_lines > 0 then
            pcall(vim.api.nvim_buf_set_extmark, bufnr, ns, diagnostic.lnum, 0, {
              virt_lines = virt_lines,
            })
          end
        end
      end

      updating = false
    end

    -- Set up autocommands to update diagnostics
    local group = vim.api.nvim_create_augroup("CustomDiagnostics", { clear = true })

    -- Use a debounced approach to avoid excessive updates
    local timers = {}
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      group = group,
      callback = function(args)
        local bufnr = args.buf

        -- Cancel existing timer for this buffer
        if timers[bufnr] then
          timers[bufnr]:stop()
        end

        -- Create new debounced timer
        timers[bufnr] = vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(bufnr) then
            show_diagnostics(bufnr)
          end
          timers[bufnr] = nil
        end, 100)  -- 100ms debounce
      end,
    })

    -- Update on buffer enter (no debounce needed)
    vim.api.nvim_create_autocmd("BufEnter", {
      group = group,
      callback = function(args)
        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(args.buf) then
            show_diagnostics(args.buf)
          end
        end, 50)
      end,
    })

    -- Configure standard diagnostics (disable virtual_text since we handle it)
    vim.diagnostic.config({
      virtual_text = false,  -- We handle this ourselves
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        wrap = true,
        max_width = 80,
      },
    })
  '';

  plugins.lsp-status = {
    enable = true;
  };

  plugins.lsp-lines = {
    enable = false; # Disabled for performance - use standard inline diagnostics
  };

  plugins.lsp-signature = {
    enable = true;
    settings = {
      always_trigger = false; # Disabled for performance - trigger manually with (
      extra_trigger_chars = [
        "("
        ","
      ];
      hint_prefix = {
        above = "↙ ";
        below = "↖ ";
        current = "← ";
      };
      padding = " ";
      shadow_guibg = "#121315";
      toggle_key = "<M-x>";
    };
  };

  plugins.lsp = {
    enable = true;
    servers = {
      nil_ls = {
        enable = true;
        settings = {};
      };
      asm_lsp = {
        enable = true;
        autostart = true;
      };
      omnisharp = {
        enable = true;
        autostart = true;
        package = pkgs.omnisharp-roslyn;
        filetypes = [
          "cs"
          "vb"
          "csproj"
          "sln"
          "slnx"
          "props"
          "csx"
          "targets"
        ];
        settings = {
          # Speed optimizations for faster startup
          analyzeOpenDocumentsOnly = true;
          enableImportCompletion = true;
          organizeImportsOnFormat = true;
          enableRoslynAnalyzers = true;
          enableDecompilationSupport = true;
          # Performance settings
          RoslynExtensionsOptions = {
            enableAnalyzersSupport = true;
            enableImportCompletion = true;
            enableDecompilationSupport = true;
            # Analyze only open files for faster startup
            analyzeOpenDocumentsOnly = true;
          };
          # Faster semantic highlighting
          FormattingOptions = {
            enableEditorConfigSupport = true;
            organizeImports = true;
          };
          # Optimize completion
          completionOptions = {
            provideRegexCompletions = false;
            provideObjectInitializerCompletion = true;
          };
        };
      };
      pylsp = {
        enable = false; # Disabled in favor of pyright
        autostart = false;
      };
      pyright = {
        enable = true;
        autostart = true;
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true;
              useLibraryCodeForTypes = true;
              diagnosticMode = "workspace";
              typeCheckingMode = "basic";
            };
          };
        };
      };
      gopls = {
        enable = true;
        autostart = true;
        settings = {
          # Performance optimizations - disable expensive real-time checks
          staticcheck = false; # CRITICAL: Staticcheck is too slow for real-time use
          completeUnimported = true;
          usePlaceholders = true;
          # Use gopls built-in analyses instead of staticcheck
          analyses = {
            unusedparams = true; # Disable this if it still feels sluggish
            shadow = false;
            fieldalignment = false;
            nilness = false;
            unusedwrite = false;
          };
          # Performance settings
          gofumpt = true; # Use faster formatter
          semanticTokens = false; # Disable semantic tokens for performance
          # Optimize completion
          matcher = "Fuzzy";
          symbolMatcher = "FastFuzzy";
          # Limit deep analysis
          deepCompletion = false;
          experimentalPostfixCompletions = false;
        };
      };
      ts_ls = {
        enable = true;
        autostart = true;
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = false;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayVariableTypeHints = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayEnumMemberValueHints = true;
            };
          };
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = false;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayVariableTypeHints = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayEnumMemberValueHints = true;
            };
          };
        };
      };
      html = {
        enable = true;
        autostart = true;
      };
      gleam = {
        enable = true;
        autostart = true;
      };
      nushell = {
        enable = false; # Disabled on macOS due to test failures - re-enable when nixpkgs nushell is fixed
        autostart = true;
      };
      kotlin_language_server = {
        enable = true;
        autostart = true;
      };
      lua_ls = {
        enable = true;
        autostart = true;
        settings = {
          completion = {
            enable = true;
            callSnippet = "Both";
            displayContext = 4;
            keywordSnippet = "Both";
            showParams = true;
            showWord = "Enable";
            workspaceWord = true;
          };
          format = {
            enable = true;
          };
          hint = {
            enable = true;
          };
          hover = {
            enable = true;
            enumsLimit = 5;
            expandAlias = true;
            previewField = 50;
            viewNumber = true;
            viewString = true;
            viewStringMax = 1000;
          };
          semantic = {
            enable = true;
            annotation = true;
            keyword = true;
            variable = true;
          };
          signatureHelp.enable = true;
          spell.dict = [
          ];
          telemetry.enable = true;
        };
      };
      rust_analyzer = {
        enable = true;
        autostart = true;
        installCargo = true;
        installRustc = true;
        settings = {
          checkOnSave = true;
          check = {
            command = "clippy";
          };
          procMacro = {
            enable = true;
          };
          cargo = {
            features = "all";
          };
        };
      };
      terraformls = {
        enable = true;
        autostart = true;
      };
      yamlls = {
        enable = false;
        autostart = false;
      };
      marksman = {
        enable = true;
        autostart = true;
      };
      zls = {
        enable = true;
        autostart = true;
      };
      bashls = {
        enable = true;
        autostart = true;
      };
      jdtls = {
        enable = true;
        autostart = true;
      };
      clangd = {
        enable = true;
        autostart = true;
        filetypes = ["c" "cpp" "objc" "objcpp"];
      };
      solargraph = {
        enable = true;
        autostart = true;
      };
    };
  };
}
