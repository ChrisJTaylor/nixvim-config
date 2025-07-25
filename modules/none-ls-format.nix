{...}: {
  plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    sources = {
      code_actions = {
        gitrebase.enable = true;
        gitsigns.enable = true;
        gomodifytags.enable = true;
        refactoring.enable = true;
      };
      formatting = {
        alejandra = {
          enable = true;
          settings = {};
        };
        just.enable = false;
        yamlfmt.enable = false;
        csharpier.enable = true;
      };
      hover = {
        dictionary.enable = true;
        printenv.enable = true;
      };
    };
  };
}
