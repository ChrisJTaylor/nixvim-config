# tmux integration module for nixvim
# Automatically configures tmux for optimal clipboard and navigation when detected
{ pkgs, ... }: {

  # Install tmux if not available (optional, can be commented out)
  extraPackages = with pkgs; [
    tmux
  ];

  # tmux-navigator plugin for seamless pane navigation
  plugins.tmux-navigator = {
    enable = true;
    settings = {
      save_on_switch = 2; # Use :update instead of :wall
      disable_when_zoomed = 1;
      preserve_zoom = 1;
    };
  };

  extraConfigLua = ''
    -- Tmux Integration and Auto-Configuration
    local tmux_session = os.getenv("TMUX")
    
    -- Configure tmux settings function (global scope)
    local function configure_tmux()
      local tmux_commands = {
        -- Enable OSC 52 passthrough
        'set-option -g allow-passthrough on',
        -- Set external clipboard
        'set-option -s set-clipboard external',
        -- Add clipboard terminal features
        'set -as terminal-features ",*:clipboard"',
        -- Optional: Configure copy-mode bindings for OSC 52
        'bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "printf \\"\\033]52;c;%s\\033\\\\\\" \\"$(base64)\\""',
        'bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "printf \\"\\033]52;c;%s\\033\\\\\\" \\"$(base64)\\""',
      }
      
      for _, cmd in ipairs(tmux_commands) do
        local full_cmd = "tmux " .. cmd .. " 2>/dev/null"
        local result = vim.fn.system(full_cmd)
        if vim.v.shell_error ~= 0 then
          print("Note: Could not set tmux option: " .. cmd)
        end
      end
      
      print("✓ tmux auto-configured for OSC 52 clipboard")
    end
    
    if tmux_session then
      -- Auto-configure tmux on nixvim startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.schedule(configure_tmux)
        end,
        once = true,
      })
      
      -- Set tmux-specific options
      vim.opt.title = true
      vim.opt.titlestring = "nixvim: %f"
      
      -- Tmux-aware terminal settings
      vim.opt.mouse = "a"
    end
    
    -- Create command to manually reconfigure tmux if needed
    vim.api.nvim_create_user_command('TmuxConfigure', function()
      if tmux_session then
        configure_tmux()
      else
        print("Not in a tmux session")
      end
    end, {
      desc = 'Configure tmux settings for OSC 52 clipboard'
    })
  '';

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>tm";
      action = ":TmuxConfigure<CR>";
      options = {
        desc = "Configure tmux for clipboard";
        silent = true;
      };
    }
  ];
}
