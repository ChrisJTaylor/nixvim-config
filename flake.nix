{
  description = "Nixvim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixvim
    , flake-utils
    , ...
    }:
    let
      inherit (flake-utils.lib) eachDefaultSystem mkApp;
    in
    eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        makeNixvim = nixvim.legacyPackages.${system}.makeNixvim;

        myNixvim = makeNixvim {
          extraPackages = [
            pkgs.clang
            pkgs.pyright # Python language server
            pkgs.python3 # Python interpreter

            # .NET/C# development
            pkgs.dotnet-sdk_8 # .NET 8 SDK for C# development
            pkgs.omnisharp-roslyn # C# LSP server

            # Go development  
            pkgs.go # Go compiler and tools
            pkgs.gopls # Go LSP server

            # Zig development
            pkgs.zig # Zig compiler
            pkgs.zls # Zig LSP server

            # Ruby development
            pkgs.ruby # Ruby interpreter
            pkgs.rubyPackages.solargraph # Ruby LSP server

            # JavaScript/TypeScript development
            pkgs.nodejs_20 # Node.js runtime
            pkgs.nodePackages.typescript # TypeScript compiler
            pkgs.nodePackages.typescript-language-server # TS LSP server

            # Java development
            pkgs.jdk21 # Java Development Kit
            pkgs.jdt-language-server # Java LSP server

            # Kotlin development
            pkgs.kotlin # Kotlin compiler
            pkgs.kotlin-language-server # Kotlin LSP server
          ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
            pkgs.xclip # X11 clipboard
          ];

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
            ./modules/colorising.nix
            ./modules/highlight.nix
            ./modules/gui-profile.nix # GUI-optimized settings
          ];
        };

        myNixvimTerminal = makeNixvim {
          extraPackages = [
            pkgs.clang
            pkgs.pyright # Python language server
            pkgs.python3 # Python interpreter

            # .NET/C# development
            pkgs.dotnet-sdk_8 # .NET 8 SDK for C# development
            pkgs.omnisharp-roslyn # C# LSP server

            # Go development  
            pkgs.go # Go compiler and tools
            pkgs.gopls # Go LSP server

            # Zig development
            pkgs.zig # Zig compiler
            pkgs.zls # Zig LSP server

            # Ruby development
            pkgs.ruby # Ruby interpreter
            pkgs.rubyPackages.solargraph # Ruby LSP server

            # JavaScript/TypeScript development
            pkgs.nodejs_20 # Node.js runtime
            pkgs.nodePackages.typescript # TypeScript compiler
            pkgs.nodePackages.typescript-language-server # TS LSP server

            # Java development
            pkgs.jdk21 # Java Development Kit
            pkgs.jdt-language-server # Java LSP server

            # Kotlin development
            pkgs.kotlin # Kotlin compiler
            pkgs.kotlin-language-server # Kotlin LSP server
          ] ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
            pkgs.xclip # X11 clipboard
          ];

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
            ./modules/colorising.nix
            ./modules/highlight.nix
            ./modules/terminal-profile.nix # Terminal-optimized settings
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
      in
      {
        packages.default = myNixvim.overrideAttrs (oldAttrs: {
          meta = {
            description = "Nixvim configuration for Neovim (GUI-optimized)";
            homepage = "https://github.com/ChrisJTaylor/nixvim-config";
            license = pkgs.lib.licenses.mit;
            maintainers = [ "ChrisJTaylor" ];
          };
        });

        packages.terminal = myNixvimTerminal.overrideAttrs (oldAttrs: {
          meta = {
            description = "Nixvim configuration for Neovim (Terminal-optimized)";
            homepage = "https://github.com/ChrisJTaylor/nixvim-config";
            license = pkgs.lib.licenses.mit;
            maintainers = [ "ChrisJTaylor" ];
          };
        });

        apps.default = mkApp {
          drv = myNixvim;
          name = "nvim";
        };

        apps.terminal = mkApp {
          drv = myNixvimTerminal;
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
          nixfmt = pkgs.runCommand "check-nixfmt" { buildInputs = [ pkgs.nixpkgs-fmt ]; } ''
            echo "Checking Nix formatting..."
            nixpkgs-fmt --check ${./modules} ${./flake.nix} || exit 1
            touch $out
          '';

          stylua = pkgs.runCommand "check-stylua" { buildInputs = [ pkgs.stylua ]; } ''
            echo "Checking Lua formatting..."
            stylua --check ${./modules} || exit 1
            touch $out
          '';
        };
      }
    );
}
