{ ... }: {
  highlight = {
    Blame = {
      fg = "#000000";
      bg = "#FFFFFF";
      italic = true;
    };

    # Make "unused"/"unnecessary" code easy to see
    DiagnosticUnnecessary = {
      fg = "#89b4fa";
      italic = true;
    };
    DiagnosticUnderlineHint = {
      undercurl = true;
      sp = "#89b4fa";
    };
    DiagnosticVirtualTextHint = {
      fg = "#89b4fa";
    };

    # Legacy groups for broader compatibility
    LspDiagnosticsDefaultHint = {
      fg = "#89b4fa";
    };
    LspDiagnosticsUnderlineHint = {
      undercurl = true;
      sp = "#89b4fa";
    };

    # Space-age enhancements
    # Enhanced cursor and selection
    Cursor = {
      fg = "#0a0a0a";
      bg = "#5ef1ff"; # Neon cyan cursor
    };

    CursorIM = {
      fg = "#0a0a0a";
      bg = "#ff5ef1"; # Neon magenta for insert mode
    };

    # Enhanced search highlighting
    Search = {
      fg = "#0a0a0a";
      bg = "#f1ff5e"; # Neon yellow search
      bold = true;
    };

    IncSearch = {
      fg = "#0a0a0a";
      bg = "#ff5ef1"; # Neon magenta incremental search
      bold = true;
    };

    # Enhanced line numbers with neon glow effect
    LineNr = {
      fg = "#5ea1ff"; # Space blue line numbers
    };

    CursorLineNr = {
      fg = "#5ef1ff"; # Bright cyan for current line
      bold = true;
    };

    # Enhanced fold column
    FoldColumn = {
      fg = "#bd5eff"; # Purple fold markers
    };

    Folded = {
      fg = "#bd5eff";
      bg = "#1a1a1a";
      italic = true;
    };

    # Enhanced status line
    StatusLine = {
      fg = "#5ef1ff";
      bg = "#111111";
      bold = true;
    };

    StatusLineNC = {
      fg = "#7b8496";
      bg = "#0a0a0a";
    };

    # Enhanced tab line for space-age feel
    TabLine = {
      fg = "#7b8496";
      bg = "#111111";
    };

    TabLineFill = {
      bg = "#0a0a0a";
    };

    TabLineSel = {
      fg = "#5ef1ff";
      bg = "#1a1a1a";
      bold = true;
    };

    # Enhanced diff highlighting
    DiffAdd = {
      fg = "#5eff6c";
      bg = "#0a2b0a";
    };

    DiffChange = {
      fg = "#f1ff5e";
      bg = "#2b2b0a";
    };

    DiffDelete = {
      fg = "#ff6e5e";
      bg = "#2b0a0a";
    };

    DiffText = {
      fg = "#5ef1ff";
      bg = "#0a1a2b";
      bold = true;
    };

    # Enhanced popup and floating window styling
    Pmenu = {
      fg = "#ffffff";
      bg = "#111111";
    };

    PmenuSel = {
      fg = "#0a0a0a";
      bg = "#5ef1ff";
      bold = true;
    };

    PmenuSbar = {
      bg = "#1a1a1a";
    };

    PmenuThumb = {
      bg = "#5ea1ff";
    };

    # Enhanced borders for floating windows
    FloatBorder = {
      fg = "#5ef1ff";
      bg = "NONE";
    };

    # Enhanced wildmenu
    WildMenu = {
      fg = "#0a0a0a";
      bg = "#ff5ef1";
      bold = true;
    };

    # Enhanced error and warning highlights
    ErrorMsg = {
      fg = "#ff6e5e";
      bg = "NONE";
      bold = true;
    };

    WarningMsg = {
      fg = "#f1ff5e";
      bg = "NONE";
      bold = true;
    };

    MoreMsg = {
      fg = "#5eff6c";
      bold = true;
    };

    # Enhanced spell checking
    SpellBad = {
      undercurl = true;
      sp = "#ff6e5e";
    };

    SpellCap = {
      undercurl = true;
      sp = "#f1ff5e";
    };

    SpellLocal = {
      undercurl = true;
      sp = "#5ef1ff";
    };

    SpellRare = {
      undercurl = true;
      sp = "#bd5eff";
    };
  };
}
