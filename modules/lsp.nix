{...}: {
  plugins.lsp-status = {
    enable = true;
  };

  plugins.lsp-lines = {
    enable = true;
  };

  plugins.lsp-signature = {
    enable = true;
    settings = {
      always_trigger = true;
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
          analyzeOpenDocumentsOnly = true;
          enableImportCompletion = true;
          organizeImportsOnFormat = true;
          enableRoslynAnalyzers = true;
          enableDecompilationSupport = true;
        };
      };
      pylsp = {
        enable = true;
        autostart = true;
        settings = {
          plugins = {
            jedi_completion.enabled = true;
            jedi_hover.enabled = true;
            jedi_references.enabled = true;
            jedi_signature_help.enabled = true;
            jedi_symbols.enabled = true;
            pycodestyle.enabled = true;
            flake8.enabled = true;
            autopep8.enabled = false;
            yapf.enabled = false;
            pylint.enabled = false;
          };
        };
      };
      gopls = {
        enable = true;
        autostart = true;
      };
      ts_ls = {
        enable = true;
        autostart = true;
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
        enable = true;
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
      sourcekit = {
        enable = true;
        autostart = true;
        filetypes = ["swift"];
      };
      solargraph = {
        enable = true;
        autostart = true;
      };
    };
  };
}
