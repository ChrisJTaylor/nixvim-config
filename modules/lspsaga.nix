{...}: {
  plugins.lspsaga = {
    enable = true;
    settings = {
      lightbulb = {
        enable = false;
        virtual_text = true;
      };
      definition = {
        height = 0.5;
        width = 0.6;
      };
      symbol_in_winbar = {
        enable = false;
        folder_level = 1;
        show_file = true;
        color_mode = true;
        hide_keyword = false;
      };
      outline = {
        auto_preview = true;
        close_after_jump = true;
        detail = true;
        auto_close = true;
        layout = "float";
        keys = {
          jump = "e";
          quit = "q";
          toggle_or_jump = "o";
        };
      };
    };
  };
}
