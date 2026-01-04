{...}: {
  plugins.colorizer = {
    enable = true;
    settings = {
      filetypes = {
        __unkeyed-1 = "*";
        __unkeyed-2 = "!vim";
        css = {
          rgb_fn = true;
        };
        html = {
          names = false;
        };
      };
      user_commands = [
        "ColorizerToggle"
        "ColorizerReloadAllBuffers"
      ];
      user_default_options = {
        mode = "virtualtext";
        names = false;
        virtualtext = "■ ";
      };
    };
  };

  plugins.highlight-colors = {
    enable = true;
    cmpIntegration = false;
    settings = {
      render = "virtual";
      virtual_symbol = "■";
      enable_named_colors = true;
    };
  };
}
