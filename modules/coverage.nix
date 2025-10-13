{ ... }: {
  plugins.coverage = {
    enable = true;
    settings = {
      auto_reload = true;
      auto_reload_timeout_ms = 2000;
      commands = true;
      lang = {
        cs = {
          lcov_file = "test-results/lcov.info";
        };
        python = {
          lcov_file = "coverage.lcov";
          coverage_command = "poetry run coverage json -q -o -";
        };
        ruby = {
          coverage_file = "coverage/coverage.json";
        };
        go = {
          coverage_file = "coverage.out";
        };
        rust = {
          coverage_file = "target/tarpaulin/lcov.info";
          coverage_command = "cargo tarpaulin --out Lcov";
        };
        java = {
          coverage_file = "target/site/jacoco/jacoco.xml";
        };
        javascript = {
          lcov_file = "coverage/lcov.info";
        };
        typescript = {
          lcov_file = "coverage/lcov.info";
        };
        zig = {
          coverage_file = "zig-out/coverage.lcov";
        };
      };
      highlights = {
        covered = {
          fg = "#B7F071";
          bg = "#4a622e";
        };
        partial = {
          fg = "#AA71F0";
          bg = "#452d64";
        };
        uncovered = {
          fg = "#F07178";
          bg = "#6b3237";
        };
        summary_cursor_line = {
          link = "CursorLine";
        };
        summary_border = {
          link = "FloatBorder";
        };
        summary_normal = {
          link = "NormalFloat";
        };
        summary_header = {
          link = "Statement";
        };
        summary_pass = {
          link = "DiagnosticOk";
        };
        summary_fail = {
          link = "DiagnosticError";
        };
      };
    };
  };
}
