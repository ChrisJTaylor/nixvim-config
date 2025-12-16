# SSH clipboard configuration
# Optimized for SSH/terminal environments using OSC 52 escape sequences
# Supports Ghostty, Windows Terminal, and other modern terminals
{ ... }: {
  opts = {
    clipboard = "unnamedplus";
  };

  extraConfigLua = ''
    -- SSH Clipboard Configuration using OSC 52
    local function setup_ssh_clipboard()
      local ssh = os.getenv("SSH_CLIENT") or os.getenv("SSH_TTY")
      local tmux = os.getenv("TMUX")
      local term = os.getenv("TERM") or ""
      local wsl = os.getenv("WSL_DISTRO_NAME")
      
      if ssh then
        -- SSH environment detected, configure OSC 52
        print("SSH session detected - configuring OSC 52 clipboard")
        vim.g.clipboard = {
          name = 'SSH-OSC52',
          copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
          },
          paste = {
            ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
            ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
          },
        }
        
        -- Note: tmux configuration is handled by tmux-integration.nix module
      end
    end
    
    -- Clipboard health check function
    local function test_clipboard()
      local test_text = "nixvim-clipboard-test-" .. os.time()
      vim.fn.setreg('+', test_text)
      vim.schedule(function()
        local retrieved = vim.fn.getreg('+')
        if retrieved == test_text then
          print("✓ Clipboard test successful!")
        else
          print("✗ Clipboard test failed - retrieved: " .. tostring(retrieved))
        end
      end)
    end
    
    -- Setup clipboard on config load
    setup_ssh_clipboard()
    
    -- Create user commands for clipboard testing
    vim.api.nvim_create_user_command('ClipboardTest', test_clipboard, {
      desc = 'Test clipboard functionality'
    })
    
    vim.api.nvim_create_user_command('ClipboardStatus', function()
      local ssh = os.getenv("SSH_CLIENT") or os.getenv("SSH_TTY")
      local tmux = os.getenv("TMUX")
      local term = os.getenv("TERM") or ""
      local clipboard_name = vim.g.clipboard and vim.g.clipboard.name or "system"
      
      print("Clipboard Status:")
      print("  Provider: " .. clipboard_name)
      print("  SSH: " .. (ssh and "✓" or "✗"))
      print("  tmux: " .. (tmux and "✓" or "✗"))
      print("  TERM: " .. term)
      print("  Clipboard setting: " .. vim.o.clipboard)
    end, {
      desc = 'Show clipboard configuration status'
    })
  '';

  # SSH-optimized clipboard keybindings
  keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>y";
      action = "\"+y";
      options = {
        desc = "Copy to system clipboard (SSH/OSC52)";
        silent = true;
      };
    }
    {
      mode = ["n" "v"];
      key = "<leader>p";
      action = "\"+p";
      options = {
        desc = "Paste from system clipboard (SSH/OSC52)";
        silent = true;
      };
    }
    {
      mode = ["n"];
      key = "<leader>ct";
      action = ":ClipboardTest<CR>";
      options = {
        desc = "Test clipboard functionality";
        silent = true;
      };
    }
    {
      mode = ["n"];
      key = "<leader>cs";
      action = ":ClipboardStatus<CR>";
      options = {
        desc = "Show clipboard status";
        silent = true;
      };
    }
  ];
}