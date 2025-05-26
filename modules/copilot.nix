{...}: {
  plugins.copilot-chat = {
    enable = true;
  };

  plugins.copilot-lua = {
    settings = {
      suggestion = {
        keymap = {
          next = "<ArrowDown>";
          previous = "<ArrowUp>";
        };
      };
    };
  };
}
