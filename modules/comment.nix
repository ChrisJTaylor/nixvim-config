{...}: {
  plugins = {
    comment = {
      enable = true;
      settings = {
        basic = true;
        extra = {
          above = "gcO";
          below = "gco";
          eol = "gcA";
        };
        toggler = {
          block = "gbc";
          line = "gcc";
        };
      };
    };
  };
}
