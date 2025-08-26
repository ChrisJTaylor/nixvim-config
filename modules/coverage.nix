{ ... }: {
  plugins.coverage = {
    enable = true;
    autoReload = true;
    autoReloadTimeoutMs = 2000;
    commands = true;
    lang = {
      cs = {
        lcovFile = "test-results/lcov.info";
      };
      python = {
        lcovFile = "coverage.lcov";
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
        lcovFile = "coverage/lcov.info";
      };
      typescript = {
        lcovFile = "coverage/lcov.info";
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
      summaryCursorLine = {
        link = "CursorLine";
      };
      summaryBorder = {
        link = "FloatBorder";
      };
      summaryNormal = {
        link = "NormalFloat";
      };
      summaryHeader = {
        link = "Statement";
      };
      summaryPass = {
        link = "DiagnosticOk";
      };
      summaryFail = {
        link = "DiagnosticError";
      };
    };
    keymaps = {
      coverage = "<leader>mc";
      summary = "<leader>mx";
    };
  };
}
