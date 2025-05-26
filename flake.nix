{
  description = "Nixvim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        makeNixvim = nixvim.legacyPackages.${system}.makeNixvim;

        myNixvim = makeNixvim {
          extraPackages = [pkgs.clang];

          imports = [
            ./modules/keymaps.nix
            ./modules/autocmds.nix
            ./modules/autosave.nix
            ./modules/telescope.nix
            ./modules/treesitter.nix
            ./modules/frecency.nix
            #    ./modules/cmp.nix
            ./modules/blink-cmp.nix
            ./modules/copilot.nix
            ./modules/lazygit.nix
            ./modules/lsp.nix
            ./modules/lsp-format.nix
            ./modules/neotree.nix
            ./modules/lspsaga.nix
            ./modules/magma.nix
            ./modules/none-ls-format.nix
            ./modules/testing.nix
            ./modules/coverage.nix
            ./modules/git.nix
            ./modules/devicons.nix
            ./modules/extraConfigLua.nix
            ./modules/zig.nix
            ./modules/smear-cursor.nix
            ./modules/vimwiki.nix
          ];

          colorschemes.cyberdream = {
            enable = true;
            settings = {
              borderless_telescope = true;
              hide_fillchars = true;
              italic_comments = true;
              terminal_colors = true;
              theme = {
                colors = {
                  # bg = "#000000";
                  # bg_alt = "#44F24F";
                  # bg_highlight = "#ff5ef1";
                  # grey = "#0D0D0D";
                  # fg = "#ffffff";
                  # blue = "#34BF49";
                  # green = "#44F24F";
                  # cyan = "#44F24F";
                  # red = "#01260A";
                  # yellow = "#44F24F";
                  # magenta = "#ff5ef1";
                  # pink = "#ff5ea0";
                  # orange = "#12732A";
                  orange = "#44F24F";
                  # purple = "#bd5eff";
                };
                highlights = {
                  Comment = {
                    bg = "#01260A";
                    fg = "#12732A";
                  };
                };
                transparent = true;
              };
            };
          };

          clipboard.providers.xclip.enable = true;

          opts = {
            number = true;
            relativenumber = true;
            shiftwidth = 2;
            clipboard = "unnamedplus";
            undofile = true;
            ignorecase = true;
            smartcase = true;
            timeoutlen = 300;
            splitright = true;
            splitbelow = true;
            scrolloff = 10;
            hlsearch = true;
          };

          plugins.dressing.enable = true;
          plugins.neo-tree = {
            enable = true;
            enableGitStatus = true;
            enableModifiedMarkers = true;
            enableRefreshOnWrite = true;
            closeIfLastWindow = true;
          };

          plugins.precognition.enable = false;

          plugins.which-key.enable = true;

          plugins.nix.enable = true;
          plugins.nix-develop.enable = true;

          plugins.rainbow-delimiters.enable = true;
        };
      in {
        packages.default = myNixvim;

        apps.default = flake-utils.lib.mkApp {
          drv = myNixvim;
          name = "nvim";
        };
      }
    );
}
