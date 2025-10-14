{ ... }: {
  plugins = {
    fugitive = {
      enable = true;
    };

    gitblame = {
      enable = true;
      settings = {
        highlight_group = "Blame";
      };
    };

    gitgutter = {
      enable = true;
    };

    git-worktree = {
      enable = true;
    };

    git-conflict = {
      enable = true;
    };

    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = false;
        signcolumn = true;
        signs = {
          add = {
            text = "+";
          };
          change = {
            text = "│";
          };
          changedelete = {
            text = "~";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          untracked = {
            text = "┆";
          };
        };
        watch_gitdir = {
          follow_files = true;
        };
      };
    };
  };
}
