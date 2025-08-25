{
  description = "Nixvim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
    ...
  }: let
    inherit (flake-utils.lib) eachDefaultSystem mkApp;
  in
    eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        makeNixvim = nixvim.legacyPackages.${system}.makeNixvim;

        myNixvim = makeNixvim {
          extraPackages = [pkgs.clang];

          imports = [
            ./modules/_top-level.nix
            ./modules/keymaps.nix
            ./modules/autocmds.nix
            ./modules/autosave.nix
            ./modules/telescope.nix
            ./modules/treesitter.nix
            ./modules/frecency.nix
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
            ./modules/render-markdown.nix
            ./modules/coverage.nix
            ./modules/git.nix
            ./modules/timerly.nix
            ./modules/devicons.nix
            ./modules/extraConfigLua.nix
            ./modules/zig.nix
            ./modules/smear-cursor.nix
            ./modules/vimwiki.nix
          ];
        };

        devTools = with pkgs; [
          neovim
          stylua
          nixpkgs-fmt
          luajit
          ripgrep
          fd
          tree-sitter
          just
        ];
      in {
        packages.default = myNixvim.overrideAttrs (oldAttrs: {
          meta = {
            description = "Nixvim configuration for Neovim";
            homepage = "https://github.com/ChrisJTaylor/nixvim-config";
            license = pkgs.lib.licenses.mit;
            maintainers = ["ChrisJTaylor"];
          };
        });

        apps.default = mkApp {
          drv = myNixvim;
          name = "nvim";
        };

        devShells.default = pkgs.mkShell {
          buildInputs = devTools;

          shellHook = ''
            just --list
          '';
        };

        formatter = pkgs.nixpkgs-fmt;

        checks = {
          nixfmt = pkgs.runCommand "check-nixfmt" {buildInputs = [pkgs.nixpkgs-fmt];} ''
            echo "Checking Nix formatting..."
            nixpkgs-fmt --check ${./modules} ${./flake.nix} || exit 1
            touch $out
          '';

          stylua = pkgs.runCommand "check-stylua" {buildInputs = [pkgs.stylua];} ''
            echo "Checking Lua formatting..."
            stylua --check ${./modules} || exit 1
            touch $out
          '';
        };
      }
    );
}
