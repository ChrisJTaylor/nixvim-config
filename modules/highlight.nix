{ ... }: {
  autoGroups = {
    custom_highlights = {
      clear = true;
    };
  };

  autoCmd = [
    {
      event = [ "ColorScheme" "VimEnter" ];
      pattern = [ "*" ];
      group = "custom_highlights";
      callback = {
        __raw = ''
          function()
            -- Schedule the highlight application to ensure it runs after the color scheme is fully loaded
            vim.schedule(function()
              local highlights = {
                Blame = { fg = "#000000", bg = "#FFFFFF", italic = true },

                -- =========================================================================
                -- COMMENT STYLING STRATEGY
                -- 1. Regular comments: Vomit-colored (Bright Green Bg + Purple Fg) to discourage use
                -- 2. Warnings: Muted Yellow Bg + Purple Fg
                -- 3. Errors: Muted Red Bg + White Fg
                -- 4. Documentation: Pleasant Everforest Green Bg + Beige Fg
                -- =========================================================================

                -- 1. REGULAR COMMENTS (VOMIT TIER)
                Comment = { fg = "#bd5eff", bg = "#5eff6c", bold = true },
                ["@comment"] = { fg = "#bd5eff", bg = "#5eff6c", bold = true },

                -- 2. WARNING COMMENTS (ALERT TIER)
                ["@comment.warning"] = { fg = "#bd5eff", bg = "#4d4c43", bold = true },
                ["@comment.todo"] = { fg = "#bd5eff", bg = "#4d4c43", bold = true },
                ["@comment.note"] = { fg = "#bd5eff", bg = "#4d4c43", bold = true },

                -- 3. ERROR COMMENTS (CRITICAL TIER)
                ["@comment.error"] = { fg = "#ffffff", bg = "#514045", bold = true },

                -- 4. DOCUMENTATION (ELEGANT TIER)
                ["@comment.documentation"] = { fg = "#d3c6aa", bg = "#425047", italic = true, bold = false },
                ["@string.documentation"] = { fg = "#d3c6aa", bg = "#425047", italic = true, bold = false },

                -- Make "unused"/"unnecessary" code easy to see
                DiagnosticUnnecessary = { fg = "#89b4fa", italic = true },
                DiagnosticUnderlineHint = { undercurl = true, sp = "#89b4fa" },
                DiagnosticVirtualTextHint = { fg = "#89b4fa" },

                -- Legacy groups for broader compatibility
                LspDiagnosticsDefaultHint = { fg = "#89b4fa" },
                LspDiagnosticsUnderlineHint = { undercurl = true, sp = "#89b4fa" },

                -- Space-age enhancements
                -- Enhanced cursor and selection
                Cursor = { fg = "#0a0a0a", bg = "#5ef1ff" },
                CursorIM = { fg = "#0a0a0a", bg = "#ff5ef1" },

                -- Enhanced search highlighting
                Search = { fg = "#0a0a0a", bg = "#f1ff5e", bold = true },
                IncSearch = { fg = "#0a0a0a", bg = "#ff5ef1", bold = true },

                -- Enhanced line numbers with neon glow effect
                LineNr = { fg = "#5ea1ff" },
                CursorLineNr = { fg = "#5ef1ff", bold = true },

                -- Enhanced fold column
                FoldColumn = { fg = "#bd5eff" },
                Folded = { fg = "#bd5eff", bg = "#1a1a1a", italic = true },

                -- Enhanced status line
                StatusLine = { fg = "#5ef1ff", bg = "#111111", bold = true },
                StatusLineNC = { fg = "#7b8496", bg = "#0a0a0a" },

                -- Enhanced tab line for space-age feel
                TabLine = { fg = "#7b8496", bg = "#111111" },
                TabLineFill = { bg = "#0a0a0a" },
                TabLineSel = { fg = "#5ef1ff", bg = "#1a1a1a", bold = true },

                -- Enhanced diff highlighting
                DiffAdd = { fg = "#5eff6c", bg = "#0a2b0a" },
                DiffChange = { fg = "#f1ff5e", bg = "#2b2b0a" },
                DiffDelete = { fg = "#ff6e5e", bg = "#2b0a0a" },
                DiffText = { fg = "#5ef1ff", bg = "#0a1a2b", bold = true },

                -- Enhanced popup and floating window styling
                Pmenu = { fg = "#ffffff", bg = "#111111" },
                PmenuSel = { fg = "#0a0a0a", bg = "#5ef1ff", bold = true },
                PmenuSbar = { bg = "#1a1a1a" },
                PmenuThumb = { bg = "#5ea1ff" },

                -- Enhanced borders for floating windows
                FloatBorder = { fg = "#5ef1ff", bg = "NONE" },

                -- Enhanced wildmenu
                WildMenu = { fg = "#0a0a0a", bg = "#ff5ef1", bold = true },

                -- Enhanced error and warning highlights
                ErrorMsg = { fg = "#ff6e5e", bg = "NONE", bold = true },
                WarningMsg = { fg = "#f1ff5e", bg = "NONE", bold = true },
                MoreMsg = { fg = "#5eff6c", bold = true },

                -- Enhanced spell checking
                SpellBad = { undercurl = true, sp = "#ff6e5e" },
                SpellCap = { undercurl = true, sp = "#f1ff5e" },
                SpellLocal = { undercurl = true, sp = "#5ef1ff" },
                SpellRare = { undercurl = true, sp = "#bd5eff" },
              }

              for group, opts in pairs(highlights) do
                -- Force the highlight (re-apply)
                vim.api.nvim_set_hl(0, group, opts)
              end
            end)
          end
        '';
      };
    }
  ];
}
