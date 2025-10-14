{ ... }: {
  extraConfigLua = ''
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    }

    -- Configure workspace settings for better LSP and Copilot integration
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local cwd = vim.fn.getcwd()
        
        -- Set workspace folder for Copilot
        vim.g.copilot_workspace_folders = { cwd }
        
        -- Check if nvim was opened with '.' argument to auto-open CopilotChat
        local args = vim.fn.argv()
        local opened_with_dot = false
        for _, arg in ipairs(args) do
          if arg == "." then
            opened_with_dot = true
            break
          end
        end
        
        if opened_with_dot then
          -- Delay opening CopilotChat to ensure plugins are loaded
          vim.defer_fn(function()
            -- Check if CopilotChat command exists
            if vim.api.nvim_create_user_command then
              pcall(function()
                vim.cmd("CopilotChat")
                print("CopilotChat opened automatically - full codebase context loaded!")
              end)
            end
          end, 2000) -- 2 second delay to ensure everything is loaded
        end
        
        -- Add to LSP workspace folders if any LSP clients are active
        vim.defer_fn(function()
          local clients = vim.lsp.get_active_clients()
          for _, client in ipairs(clients) do
            if client.server_capabilities.workspaceFolders then
              vim.lsp.buf.add_workspace_folder(cwd)
              break
            end
          end
        end, 1000)
      end,
    })

    -- Ensure Copilot workspace is updated when changing directories
    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        local cwd = vim.fn.getcwd()
        vim.g.copilot_workspace_folders = { cwd }
      end,
    })

    -- Add command to manually refresh Copilot workspace context
    vim.api.nvim_create_user_command("CopilotRefresh", function()
      local cwd = vim.fn.getcwd()
      vim.g.copilot_workspace_folders = { cwd }
      print("Copilot workspace refreshed for: " .. cwd)
    end, { desc = "Refresh Copilot workspace context" })

    -- Add command to open CopilotChat with full context
    vim.api.nvim_create_user_command("CopilotChatOpen", function()
      vim.cmd("CopilotChat")
      print("CopilotChat opened with full codebase context!")
    end, { desc = "Open CopilotChat with full codebase context" })

    -- Add command to show how many files are being indexed
    vim.api.nvim_create_user_command("CopilotChatContext", function()
      local cwd = vim.fn.getcwd()
      local git_files = vim.fn.systemlist("git ls-files 2>/dev/null")
      if vim.v.shell_error == 0 then
        print("CopilotChat has access to " .. #git_files .. " files in this git repository")
      else
        print("CopilotChat will scan for source files in: " .. cwd)
      end
    end, { desc = "Show CopilotChat context information" })

    -- Add manual Copilot suggestion trigger (Ctrl+Space)
    vim.keymap.set('i', '<C-Space>', function()
      require('copilot.suggestion').next()
    end, { desc = 'Trigger Copilot suggestion' })

    -- Add toggle for Copilot suggestions when you want them
    vim.keymap.set('n', '<leader>cs', function()
      require('copilot.suggestion').toggle_auto_trigger()
      print("Copilot auto-trigger toggled")
    end, { desc = 'Toggle Copilot auto-trigger' })
  '';
}
