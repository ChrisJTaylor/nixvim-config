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
        
        -- Add to LSP workspace folders if any LSP clients are active
        vim.defer_fn(function()
          local clients = vim.lsp.get_clients()
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

    -- Add command to open CopilotChat with project context using new resource syntax
    vim.api.nvim_create_user_command("CopilotChatOpen", function()
      vim.cmd("CopilotChat #glob:**/* #glob:**/*.md #glob:**/*.txt #glob:**/*.json #glob:**/*.yaml #glob:**/*.yml Hi! I'm working on this codebase. Can you see the file structure and help me understand the project?")
      print("CopilotChat opened with full project context using resource syntax!")
    end, { desc = "Open CopilotChat with project context" })

    -- Add command to show project information using new resource syntax
    vim.api.nvim_create_user_command("CopilotChatContext", function()
      local cwd = vim.fn.getcwd()
      local git_files = vim.fn.systemlist("git ls-files 2>/dev/null")
      if vim.v.shell_error == 0 then
        print("CopilotChat can access " .. #git_files .. " files using resource syntax")
        print("Examples: #glob:**/*.py #glob:**/*.js #glob:**/*.rs #glob:**/*.go")
        print("          #buffer:active (current file) | #gitdiff:staged (git changes)")
        print("          @copilot (enable AI tools for search/edit)")
      else
        print("CopilotChat will use resource syntax like #glob:**/* to access files in: " .. cwd)
        print("Try: #glob:**/*.ext for specific file types, or #buffer:active for current file")
      end
    end, { desc = "Show CopilotChat resource syntax information" })

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
