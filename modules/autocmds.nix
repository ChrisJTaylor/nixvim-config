{...}: {
  autoGroups = {
    highlight_yank.clear = true;
    auto_test.clear = true;
    auto_coverage.clear = true;
  };

  autoCmd = [
    {
      event = ["TextYankPost"];
      group = "highlight_yank";
      command = "silent! lua vim.highlight.on_yank{higroup='Search', timeout=200}";
    }

    {
      event = ["BufWritePost"];
      pattern = ["go.mod"];
      callback = {
        __raw = "function()
              vim.cmd('!go mod tidy')
            end";
      };
    }
    # Auto-test on save for Go files
    {
      event = ["BufWritePost"];
      pattern = ["*.go"];
      group = "auto_test";
      callback = {
        __raw = "function()
              -- Auto-test with coverage
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                  vim.defer_fn(function()
                    vim.cmd('CoverageShow')
                  end, 500)
                end, 500)
              end, 100)
            end";
      };
    }

    # Auto-test on save for other supported languages
    {
      event = ["BufWritePost"];
      pattern = [
        "*.cs"
        "*.csproj"
        "*.sln"
        "*.py"
        "*.rb"
        "*.rs"
        "*.java"
        "*.js"
        "*.jsx"
        "*.ts"
        "*.tsx"
        "*.zig"
      ];
      group = "auto_test";
      callback = {
        __raw = "function()
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                  vim.defer_fn(function()
                    vim.cmd('CoverageShow')
                  end, 500)
                end, 500)
              end, 100)
            end";
      };
    }
  ];
}
