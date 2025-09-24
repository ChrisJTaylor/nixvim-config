{ ... }: {
  plugins.neo-tree = {
    enable = true;
    enableGitStatus = true;
    enableModifiedMarkers = true;
    enableRefreshOnWrite = true;
    closeIfLastWindow = true;

    buffers = {
      followCurrentFile.enabled = true;
      followCurrentFile.leaveDirsOpen = true;
    };

    settings = {
      filesystem = {
        filtered_items = {
          visible = true;
          hide_dotfiles = false;
          hide_gitignored = false;
          never_show = [ ".git" ];
        };
      };
    };
  };
}
