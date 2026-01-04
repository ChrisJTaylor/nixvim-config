{...}: {
  plugins.neo-tree = {
    enable = true;
    settings = {
      enable_git_status = true;
      enable_modified_markers = true;
      enable_refresh_on_write = true;
      close_if_last_window = true;

      buffers = {
        follow_current_file = {
          enabled = true;
          leave_dirs_open = true;
        };
      };

      filesystem = {
        filtered_items = {
          visible = true;
          hide_dotfiles = false;
          hide_gitignored = false;
          never_show = [".git"];
        };
      };
    };
  };
}
