# Coding Agent Instructions for nixvim-config

## Build/Test Commands
- Build: `just build` or `nix build`
- Run: `just run` or `nix run` 
- Check/Lint: `just check` or `nix flake check`
- Format: `just format` or `nix fmt`
- Update dependencies: `just update` or `nix flake update`
- Run single test: Use neotest commands in Neovim (`:lua require("neotest").run.run()`)
- Development shell: `nix develop` (includes dev tools like stylua, nixpkgs-fmt, just)

## Code Style & Structure
- **Language**: Nix expressions using nixvim syntax (NOT raw Lua/Vim)
- **Formatting**: Use nixpkgs-fmt for Nix files, stylua for Lua (enforced via `nix fmt`)
- **Indentation**: 2 spaces, no tabs
- **Module structure**: Each feature in separate `.nix` file under `modules/`
- **Imports**: Add new modules to `flake.nix` imports array (lines 32-61)
- **Naming**: Use kebab-case for files, camelCase for Nix attributes
- **Function syntax**: `{ ... }: { }` pattern for module definitions
- **Leader key**: Space (`<leader>` = `" "`), local leader is `<Tab>`
- **Platform support**: Linux (full), macOS (no Magma), Windows WSL
- **Git integration**: Uses diffview for merge conflicts and git diffs, lightline for statusline
- **UI modules**: neotree (file explorer), telescope (fuzzy finder), render-markdown, smear-cursor

## Error Handling & Testing
- Test configuration with `nix build` before committing
- Use neotest for multi-language testing (dotnet, go, java, rust, python, jest, vitest, zig, rspec, plenary)
- Available test commands: `:lua require("neotest").run.run()` (single test), `:lua require("neotest").run.run(vim.fn.expand("%"))` (file), `:lua require("neotest").summary.toggle()` (summary)
- Automated checks: nixpkgs-fmt and stylua formatting validation via `nix flake check`
- Ensure cross-platform compatibility (Linux/macOS/Windows WSL)
- Check existing `.copilot-instructions.md` for comprehensive context

## Commit Standards
- Use conventional commits (enforced via cocogitto/cog.toml)
- Format: `type(scope): description`
- Run `just check` before committing to validate formatting and build