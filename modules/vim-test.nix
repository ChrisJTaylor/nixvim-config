{...}: {
  plugins.vim-test = {
    enable = true;
    settings = {
      strategy = "neovim_sticky";
      preserve_screen = true;
      "neovim#term_position" = "vert botright 40";
      "neovim_sticky#kill_previous" = 1;
      "neovim_sticky#reopen_window" = 1;
      "neovim_sticky#use_existing" = 1;
    };
  };

  extraConfigLua = ''
    local vimTestFiletypes = {
      javascript = true,
      javascriptreact = true,
      typescript = true,
      typescriptreact = true,
    }

    local vitestConfigFiles = {
      'vitest.config.ts',
      'vitest.config.js',
      'vitest.config.mts',
      'vitest.config.mjs',
    }

    local function hasVitestPackage(path)
      local packageJson = vim.fs.find('package.json', {
        path = path,
        upward = true,
      })[1]

      if not packageJson then
        return false
      end

      local ok, lines = pcall(vim.fn.readfile, packageJson)
      if not ok then
        return false
      end

      local contents = table.concat(lines, '\n')
      local okJson, parsed = pcall(vim.json.decode, contents)
      if not okJson or type(parsed) ~= 'table' then
        return contents:match('"vitest"') ~= nil
      end

      for _, field in ipairs({ 'dependencies', 'devDependencies' }) do
        local deps = parsed[field]
        if type(deps) == 'table' and deps.vitest then
          return true
        end
      end

      if type(parsed.scripts) == 'table' then
        for _, value in pairs(parsed.scripts) do
          if type(value) == 'string' and value:match('vitest') then
            return true
          end
        end
      end

      return false
    end

    local function useVimTest()
      if vimTestFiletypes[vim.bo.filetype] ~= true then
        return false
      end

      local bufferPath = vim.api.nvim_buf_get_name(0)
      local searchPath = bufferPath ~= "" and vim.fs.dirname(bufferPath) or vim.fn.getcwd()

      return vim.fs.find(vitestConfigFiles, {
        path = searchPath,
        upward = true,
      })[1] ~= nil or hasVitestPackage(searchPath)
    end

    local function withNeotest(callback)
      local ok, neotest = pcall(require, 'neotest')
      if not ok then
        vim.notify('neotest is not available', vim.log.levels.ERROR)
        return
      end

      callback(neotest)
    end

    local function notifyVimTest(feature)
      vim.notify(
        ('%s is not available through vim-test. Use :TestNearest, :TestFile, :TestSuite, or :TestLast instead.'):format(feature),
        vim.log.levels.INFO
      )
    end

    vim.api.nvim_create_user_command('SmartTestNearest', function()
      if useVimTest() then
        vim.cmd('TestNearest')
        return
      end

      withNeotest(function(neotest)
        neotest.run.run()
      end)
    end, {})

    vim.api.nvim_create_user_command('SmartTestFile', function()
      if useVimTest() then
        vim.cmd('TestFile')
        return
      end

      withNeotest(function(neotest)
        neotest.run.run(vim.fn.expand('%'))
      end)
    end, {})

    vim.api.nvim_create_user_command('SmartTestSuite', function()
      if useVimTest() then
        vim.cmd('TestSuite')
        return
      end

      withNeotest(function(neotest)
        neotest.run.run(vim.fn.getcwd())
      end)
    end, {})

    vim.api.nvim_create_user_command('SmartTestLast', function()
      if useVimTest() then
        vim.cmd('TestLast')
        return
      end

      withNeotest(function(neotest)
        neotest.run.run_last()
      end)
    end, {})

    vim.api.nvim_create_user_command('SmartTestSummary', function()
      if useVimTest() then
        notifyVimTest('A test summary panel')
        return
      end

      vim.cmd('Neotest summary')
    end, {})

    vim.api.nvim_create_user_command('SmartTestWatch', function()
      if useVimTest() then
        notifyVimTest('Watch mode')
        return
      end

      withNeotest(function(neotest)
        neotest.watch.toggle(vim.fn.expand('%'))
      end)
    end, {})

    vim.api.nvim_create_user_command('SmartTestDebug', function()
      if useVimTest() then
        notifyVimTest('Debug test execution')
        return
      end

      withNeotest(function(neotest)
        neotest.run.run({ strategy = 'dap' })
      end)
    end, {})

    vim.api.nvim_create_user_command('SmartTestOutput', function()
      if useVimTest() then
        vim.notify('vim-test writes output directly to its terminal window.', vim.log.levels.INFO)
        return
      end

      vim.cmd('Neotest output')
    end, {})
  '';
}
