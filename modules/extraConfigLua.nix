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

    -- Configure Copilot workspace settings for better repo awareness
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local cwd = vim.fn.getcwd()
        -- Set workspace folder for better context
        vim.g.copilot_workspace_folders = { cwd }
        
        -- Configure Copilot Chat for repository awareness
        local copilot_chat = require('CopilotChat')
        if copilot_chat and copilot_chat.setup then
          -- Ensure Chat understands the repository structure
          vim.g.copilot_chat_config = vim.tbl_deep_extend("force", vim.g.copilot_chat_config or {}, {
            context = {
              workspace = cwd,
              git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\\n", ""),
              include_patterns = {
                "*.nix",
                "*.md", 
                "flake.*",
                "justfile",
                "*.json",
                "*.yaml",
                "*.yml"
              }
            }
          })
        end
        
        -- Also add to LSP workspace folders if any LSP clients are active
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

    -- Ensure Copilot has access to the full repository context
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        local cwd = vim.fn.getcwd()
        vim.g.copilot_workspace_folders = { cwd }
        
        -- Update Chat context for current directory
        if vim.g.copilot_chat_config then
          vim.g.copilot_chat_config.context = vim.g.copilot_chat_config.context or {}
          vim.g.copilot_chat_config.context.workspace = cwd
        end
      end,
    })

    -- Add command to manually refresh Copilot Chat context
    vim.api.nvim_create_user_command("CopilotChatRefresh", function()
      local cwd = vim.fn.getcwd()
      vim.g.copilot_workspace_folders = { cwd }
      print("Copilot Chat context refreshed for: " .. cwd)
    end, { desc = "Refresh Copilot Chat repository context" })

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
