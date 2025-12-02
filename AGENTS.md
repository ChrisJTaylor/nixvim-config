# Coding Agent Instructions for nixvim-config

## Build/Test Commands
- **Build**: `just build` or `nix build` (test configuration)
- **Run**: `just run` or `nix run` (default GUI version), `nix run .#terminal` (terminal version)
- **Check/Lint**: `just check` or `nix flake check` (validates formatting and builds)
- **Format**: `just format` or `nix fmt` (nixpkgs-fmt + stylua)
- **Update**: `just update` or `nix flake update` (update flake dependencies)
- **Dev Shell**: `nix develop` (includes stylua, nixpkgs-fmt, just, ripgrep, fd, tree-sitter)
- **Single Test**: `:lua require("neotest").run.run()` (current), `:lua require("neotest").run.run(vim.fn.expand("%"))` (file)
- **Test Summary**: `:lua require("neotest").summary.toggle()` (test results overview)

## Code Style & Structure
- **Language**: Nix expressions using nixvim syntax (NOT raw Lua/Vim scripts)
- **Formatting**: nixpkgs-fmt for .nix files, stylua for .lua files (auto-checked via `nix flake check`)
- **Indentation**: 2 spaces, no tabs throughout codebase
- **Module Pattern**: `{...}: { }` function syntax for all module definitions
- **File Organization**: Each feature in separate `.nix` file under `modules/` directory
- **Imports**: Add new modules to `flake.nix` imports array (lines 32-61 for GUI, 69-99 for terminal)
- **Naming**: kebab-case for filenames, camelCase for Nix attribute names
- **Profiles**: GUI-specific settings in `gui-profile.nix`, terminal-specific in `terminal-profile.nix`
- **Key Bindings**: Leader key is Space, local leader is Tab, avoid conflicts with existing bindings

## Platform & Testing
- **Linux**: Full support including Jupyter/Magma integration and X11 clipboard (xclip)
- **macOS**: Full support except Magma (disabled due to ueberzug dependency issues)
- **Windows**: Supported via WSL2 environment
- **Auto-Testing**: Files tested on save with neotest, visual coverage feedback via coverage.nix
- **Test Frameworks**: dotnet, go, java, rust, python, jest, vitest, zig, rspec, plenary via neotest
- **Pre-Commit**: Always run `just check` before commits to validate formatting and build success

## Commit Standards
- **Format**: Conventional commits enforced via cocogitto (cog.toml configuration)
- **Structure**: `type(scope): description` (e.g., `feat(lsp): add rust-analyzer configuration`)
- **Validation**: `just check` validates formatting, build, and Nix/Lua syntax before commits