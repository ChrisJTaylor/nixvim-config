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
  };
}
