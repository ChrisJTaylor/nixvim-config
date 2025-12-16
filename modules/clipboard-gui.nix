# GUI clipboard configuration
# Optimized for local GUI environments with X11/Wayland display servers
{ pkgs, ... }: {
  clipboard.providers = {
    xclip.enable = pkgs.stdenv.isLinux;
  };

  opts = {
    clipboard = "unnamedplus";
  };

  # GUI-specific clipboard keybindings
  keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>y";
      action = "\"+y";
      options = {
        desc = "Copy to system clipboard (GUI)";
        silent = true;
      };
    }
    {
      mode = ["n" "v"];
      key = "<leader>p";
      action = "\"+p";
      options = {
        desc = "Paste from system clipboard (GUI)";
        silent = true;
      };
    }
  ];
}