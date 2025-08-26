{...}: {
  globals = {
    mapleader = " ";
    maplocalleader = "<Tab>";
  };

  keymaps = [
    # neotree
    {
      mode = "n";
      key = "<ESC>";
      action = "<cmd>nohlsearch<CR>";
    }
    {
      mode = "n";
      key = "<leader>ef";
      options.silent = true;
      action = "<cmd>:Neotree filesystem reveal<CR>";
      options.desc = "Filesystem";
    }
    {
      mode = "n";
      key = "<leader>efl";
      options.silent = true;
      action = "<cmd>:Neotree filesystem reveal left<CR>";
      options.desc = "Show file explorer (left)";
    }
    {
      mode = "n";
      key = "<leader>efr";
      options.silent = true;
      action = "<cmd>:Neotree filesystem reveal right<CR>";
      options.desc = "Show file explorer (right)";
    }
    {
      mode = "n";
      key = "<leader>eb";
      options.silent = true;
      action = "<cmd>:Neotree buffers reveal<CR>";
      options.desc = "Open files";
    }
    {
      mode = "n";
      key = "<leader>ebl";
      options.silent = true;
      action = "<cmd>:Neotree buffers reveal left<CR>";
      options.desc = "Show all open files in explorer (left)";
    }
    {
      mode = "n";
      key = "<leader>ebr";
      options.silent = true;
      action = "<cmd>:Neotree buffers reveal right<CR>";
      options.desc = "Show all open files in explorer (right)";
    }
    {
      mode = "n";
      key = "<leader>eg";
      options.silent = true;
      action = "<cmd>:Neotree git_status reveal<CR>";
      options.desc = "Changed files";
    }
    {
      mode = "n";
      key = "<leader>egl";
      options.silent = true;
      action = "<cmd>:Neotree git_status reveal left<CR>";
      options.desc = "Show git status in explorer (left)";
    }
    {
      mode = "n";
      key = "<leader>egr";
      options.silent = true;
      action = "<cmd>:Neotree git_status reveal right<CR>";
      options.desc = "Show git status in explorer (right)";
    }

    # vim shortcuts
    {
      mode = "n";
      key = "<leader>q";
      options.silent = true;
      action = "<cmd>:q!<CR>";
      options.desc = "Quit";
    }
    {
      mode = "n";
      key = "<leader>|";
      options.silent = true;
      action = "<C-w><C-v>";
      options.desc = "Split across";
    }
    {
      mode = "n";
      key = "<leader>-";
      options.silent = true;
      action = "<C-w><C-s>";
      options.desc = "Split down";
    }
    {
      mode = "n";
      key = "<leader>w";
      options.silent = true;
      action = "<C-w><C-w>";
      options.desc = "Switch windows";
    }
    {
      mode = "n";
      key = "<leader>m";
      options.silent = true;
      action = "<cmd>:marks<CR>";
      options.desc = "List all marks";
    }
    {
      mode = "n";
      key = "<C-u>";
      options.silent = true;
      action = "<C-u>zz";
      options.desc = "Move up";
    }
    {
      mode = "n";
      key = "<C-d>";
      options.silent = true;
      action = "<C-d>zz";
      options.desc = "Move down";
    }
    {
      mode = "n";
      key = "G";
      options.silent = true;
      action = "Gzz";
      options.desc = "Move to the end";
    }
    {
      mode = "n";
      key = "<C-h>";
      options.silent = true;
      action = "<C-w><C-h>";
      options.desc = "Move focus to left window";
    }
    {
      mode = "n";
      key = "<C-j>";
      options.silent = true;
      action = "<C-w><C-j>";
      options.desc = "Move focus to lower window";
    }
    {
      mode = "n";
      key = "<C-k>";
      options.silent = true;
      action = "<C-w><C-k>";
      options.desc = "Move focus to upper window";
    }
    {
      mode = "n";
      key = "<C-l>";
      options.silent = true;
      action = "<C-w><C-l>";
      options.desc = "Move focus to right window";
    }
    {
      mode = "n";
      key = "<leader>={";
      options.silent = true;
      action = "=%";
      options.desc = "re-indent block with braces";
    }
    {
      mode = "n";
      key = "<leader>=(";
      options.silent = true;
      action = ">ib";
      options.desc = "Indent inner block with parentheses";
    }
    {
      mode = "n";
      key = "<leader>=<";
      options.silent = true;
      action = ">at";
      options.desc = "Indent inner block with angle brackets";
    }

    # Lspsaga
    {
      mode = "n";
      key = "K";
      options.silent = true;
      action = "<CMD>Lspsaga hover_doc<Enter>";
      options.desc = "Tooltip";
    }
    {
      mode = "n";
      key = "<leader>a";
      options.silent = true;
      action = "<cmd>:Lspsaga code_action<CR>";
      options.desc = "Show code actions";
    }
    {
      mode = "n";
      key = "t";
      options.silent = true;
      action = "<cmd>:Lspsaga term_toggle<CR>";
      options.desc = "Show floating terminal";
    }
    {
      mode = "n";
      key = "<leader>k";
      options.silent = true;
      action = "<cmd>:Lspsaga hover_doc<CR>";
      options.desc = "Show doc";
    }
    {
      mode = "n";
      key = "<leader>K";
      options.silent = true;
      action = "<cmd>:Lspsaga hover_doc ++keep<CR>";
      options.desc = "Show doc (keep open)";
    }
    {
      mode = "n";
      key = "<leader>f";
      options.silent = true;
      action = "<cmd>:Lspsaga finder ref<CR>";
      options.desc = "Show LSP finder (references)";
    }
    {
      mode = "n";
      key = "<leader>F";
      options.silent = true;
      action = "<cmd>:Lspsaga finder def+ref+imp<CR>";
      options.desc = "Show LSP finder (definitions, references and implementations";
    }

    # neotest shortcuts
    {
      mode = "n";
      key = "<leader>ts";
      options.silent = true;
      action = "<cmd>:Neotest summary<CR>";
      options.desc = "Show test panel";
    }
    {
      mode = "n";
      key = "<leader>tr";
      options.silent = true;
      action = "<cmd>:lua require('neotest').run.run(vim.loop.cwd())<CR>";
      options.desc = "Run all tests";
    }
    {
      mode = "n";
      key = "<leader>tf";
      options.silent = true;
      action = "<cmd>:lua require('neotest').run.run(vim.fn.expand('%'))<CR>";
      options.desc = "Run current file tests";
    }
    {
      mode = "n";
      key = "<leader>tn";
      options.silent = true;
      action = "<cmd>:lua require('neotest').run.run()<CR>";
      options.desc = "Run nearest test";
    }
    {
      mode = "n";
      key = "<leader>tl";
      options.silent = true;
      action = "<cmd>:lua require('neotest').run.run_last()<CR>";
      options.desc = "Run last test";
    }
    {
      mode = "n";
      key = "<leader>tw";
      options.silent = true;
      action = "<cmd>:lua require('neotest').watch.toggle(vim.fn.expand('%'))<CR>";
      options.desc = "Toggle watch current file (neotest)";
    }
    {
      mode = "n";
      key = "<leader>td";
      options.silent = true;
      action = "<cmd>:lua require('neotest').run.run({strategy = 'dap'})<CR>";
      options.desc = "Debug nearest test";
    }
    {
      mode = "n";
      key = "<leader>to";
      options.silent = true;
      action = "<cmd>:Neotest output<CR>";
      options.desc = "Show test output";
    }

    # coverage
    {
      mode = "n";
      key = "<leader>ll";
      options.silent = true;
      action = "<cmd>:CoverageLoad<CR>";
      options.desc = "Load coverage";
    }
    {
      mode = "n";
      key = "<leader>ls";
      options.silent = true;
      action = "<cmd>:CoverageShow<CR>";
      options.desc = "Show coverage";
    }
    {
      mode = "n";
      key = "<leader>lm";
      options.silent = true;
      action = "<cmd>:CoverageSummary<CR>";
      options.desc = "Display coverage summary";
    }
    {
      mode = "n";
      key = "<leader>lt";
      options.silent = true;
      action = "<cmd>:CoverageToggle<CR>";
      options.desc = "Toggle coverage";
    }

    # refactoring
    {
      mode = "n";
      key = "<leader>rr";
      options.silent = true;
      action = "<cmd>:lua require('telescope').extensions.refactoring.refactors()<CR>";
      options.desc = "Refactorings";
    }

    {
      mode = "n";
      key = "<leader>gg";
      options.silent = true;
      action = "<cmd>:LazyGit<CR>";
      options.desc = "LazyGit";
    }

    # utilities
    {
      mode = "n";
      key = "<leader>tm";
      options.silent = true;
      action = "<cmd>:TimerlyToggle<CR>";
      options.desc = "Timerly toggle";
    }

    # copilot
    {
      mode = "n";
      key = "<leader>cc";
      options.silent = true;
      action = "<cmd>:CopilotChat<CR>";
      options.desc = "Copilot Chat";
    }
    {
      mode = "n";
      key = "<leader>ce";
      options.silent = true;
      action = "<cmd>:CopilotChatExplain<CR>";
      options.desc = "Explain selection";
    }
    {
      mode = "n";
      key = "<leader>cf";
      options.silent = true;
      action = "<cmd>:CopilotChatFix<CR>";
      options.desc = "Fix this";
    }
    {
      mode = "n";
      key = "<leader>cd";
      options.silent = true;
      action = "<cmd>:CopilotChatDocs<CR>";
      options.desc = "Add documentation comments to the selected code";
    }
    {
      mode = "n";
      key = "<leader>cm";
      options.silent = true;
      action = "<cmd>:CopilotChatCommit<CR>";
      options.desc = "Write commit message";
    }
    {
      mode = "n";
      key = "<leader>cr";
      options.silent = true;
      action = "<cmd>:CopilotChatReview<CR>";
      options.desc = "Review code";
    }
    {
      mode = "n";
      key = "<leader>co";
      options.silent = true;
      action = "<cmd>:CopilotChatOptimize<CR>";
      options.desc = "Optimize code";
    }
    {
      mode = "n";
      key = "<leader>ct";
      options.silent = true;
      action = "<cmd>:CopilotChatTests<CR>";
      options.desc = "Write tests for the selected code";
    }
    {
      mode = "n";
      key = "<leader>cs";
      options.silent = true;
      action = "<cmd>:CopilotChatSave<CR>";
      options.desc = "Save history";
    }
  ];
}
