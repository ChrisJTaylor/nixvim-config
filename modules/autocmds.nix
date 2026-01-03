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
              vim.lsp.buf.execute_command({ command = 'gopls.workspace.reload' })
            end";
      };
    }
    # Combined Go LSP and auto-test on save
    {
      event = ["BufWritePost"];
      pattern = ["*.go"];
      group = "auto_test";
      callback = {
        __raw = "function()
              -- LSP reload for Go
              vim.lsp.buf.execute_command({ command = 'gopls.workspace.reload' })
              
              -- Auto-test with coverage
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                end, 1000)
              end, 100)
            end";
      };
    }

    # Auto-test on save for other supported languages
    {
      event = ["BufWritePost"];
      pattern = ["*.cs" "*.csproj" "*.sln"];
      group = "auto_test";
      callback = {
        __raw = "function()
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                end, 1000)
              end, 100)
            end";
      };
    }
    {
      event = ["BufWritePost"];
      pattern = ["*.py"];
      group = "auto_test";
      callback = {
        __raw = "function()
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                end, 1000)
              end, 100)
            end";
      };
    }
    {
      event = ["BufWritePost"];
      pattern = ["*.rb"];
      group = "auto_test";
      callback = {
        __raw = "function()
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                end, 1000)
              end, 100)
            end";
      };
    }
    {
      event = ["BufWritePost"];
      pattern = ["*.rs"];
      group = "auto_test";
      callback = {
        __raw = "function()
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                end, 1000)
              end, 100)
            end";
      };
    }
    {
      event = ["BufWritePost"];
      pattern = ["*.java"];
      group = "auto_test";
      callback = {
        __raw = "function()
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                end, 1000)
              end, 100)
            end";
      };
    }
    {
      event = ["BufWritePost"];
      pattern = ["*.js" "*.jsx" "*.ts" "*.tsx"];
      group = "auto_test";
      callback = {
        __raw = "function()
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                end, 1000)
              end, 100)
            end";
      };
    }
    {
      event = ["BufWritePost"];
      pattern = ["*.zig"];
      group = "auto_test";
      callback = {
        __raw = "function()
              local file = vim.fn.expand('%:p')
              vim.defer_fn(function()
                require('neotest').run.run(file)
                vim.defer_fn(function()
                  vim.cmd('CoverageLoad')
                end, 1000)
              end, 100)
            end";
      };
    }

    # Auto-reload coverage when test results change
    {
      event = ["User"];
      pattern = ["NeotestFinished"];
      group = "auto_coverage";
      callback = {
        __raw = "function()
              vim.defer_fn(function()
                vim.cmd('CoverageLoad')
              end, 500)
            end";
      };
    }
  ];
}
