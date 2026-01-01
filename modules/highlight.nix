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
                Comment = { fg = "#bd5eff", bg = "#4b424c", bold = true },
                ["@comment"] = { fg = "#bd5eff", bg = "#4b424c", bold = true },

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

                -- Space-age enhancements (UI Chrome overrides removed to respect Everforest theme)

                -- Enhanced cursor and selection (Kept as requested)
                Cursor = { fg = "#0a0a0a", bg = "#5ef1ff" },
                CursorIM = { fg = "#0a0a0a", bg = "#ff5ef1" },

                -- Enhanced search highlighting (Kept as requested)
                Search = { fg = "#0a0a0a", bg = "#f1ff5e", bold = true },
                IncSearch = { fg = "#0a0a0a", bg = "#ff5ef1", bold = true },

                -- Enhanced line numbers with neon glow effect (Kept)
                LineNr = { fg = "#5ea1ff" },
                CursorLineNr = { fg = "#5ef1ff", bold = true },

                -- Enhanced error and warning highlights (Text only)
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
