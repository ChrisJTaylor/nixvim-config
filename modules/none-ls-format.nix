{ ... }: {
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
          settings = { };
        };
        # Prefer OmniSharp over csharpier for .editorconfig compliance
        csharpier.enable = false;
        # Use Prettier for JS/TS and disable tsserver formatting
        prettierd = {
          enable = true;
          disableTsServerFormatter = true;
        };
        # Add shfmt for shell scripts
        shfmt = {
          enable = true;
          settings = {
            # Use 2-space indent by default; editorconfig sets buffer shiftwidth
            # None-ls can't read buffer opts here, so choose a sane default
            extra_args = [ "-i" "2" "-sr" "-bn" ];
          };
        };
        just.enable = false;
        yamlfmt.enable = false;
      };
      hover = {
        dictionary.enable = true;
        printenv.enable = true;
      };
    };
  };
}
