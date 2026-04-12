# Coding Agent Instructions for nixvim-config

This is a **NixVim configuration repository** providing a comprehensive Neovim setup with NCrunch-style continuous testing, GitHub Copilot integration, and multi-language support. Configuration is written in Nix (NOT raw Lua/Vim scripts).

## Build/Test Commands

### Build & Run
- **Build GUI**: `just build-gui` or `nix build .` (test GUI configuration)
- **Build Terminal**: `just build-term` or `nix build .#terminal` (test terminal configuration)
- **Run GUI**: `just run-gui` or `nix run .` (default GUI version)
- **Run Terminal**: `just run-term` or `nix run .#terminal` (terminal version with OSC 52 clipboard)
- **Dev Shell**: `nix develop` (includes stylua, nixpkgs-fmt, just, ripgrep, fd, tree-sitter)

### Quality & Maintenance
- **Check/Lint**: `just check` or `nix flake check` (validates formatting, builds all profiles)
- **Format Code**: `just format` or `nix fmt .` (runs nixpkgs-fmt on all .nix files)
- **Format Check**: `just format-check` (verify formatting without modifying files)
- **Update Dependencies**: `just update` or `nix flake update` (updates flake.lock)

### Testing (Inside Neovim)
- **Run Current Test**: `:lua require("neotest").run.run()` (test under cursor)
- **Run File Tests**: `:lua require("neotest").run.run(vim.fn.expand("%"))` (all tests in file)
- **Toggle Test Summary**: `:lua require("neotest").summary.toggle()` (test panel)
- **Toggle Test Output**: `:lua require("neotest").output_panel.toggle()` (test output)
- **Clipboard Test**: Use `<leader>ct` keymap to test clipboard functionality

## Code Style & Structure

### Language & Syntax
- **Language**: Nix expressions using nixvim module syntax (NOT raw Lua/Vim/vimscript)
- **Module Pattern**: Always use `{...}: { }` or `{pkgs, ...}: { }` function syntax for modules
- **Lua Code**: Only use Lua in `extraConfigLua` strings for advanced vim.api customization
- **Plugin Config**: Use nixvim's declarative plugin options, NOT raw Lua setup() calls

### Formatting & Style
- **Formatters**: nixpkgs-fmt for .nix files, stylua for .lua files (if any)
- **Indentation**: 2 spaces (no tabs) throughout entire codebase
- **Line Length**: No hard limit, but keep lines readable (typically < 120 chars)
- **Trailing Commas**: Not required in Nix attribute sets/lists
- **Comments**: Use `#` for Nix comments, `--` for Lua (in extraConfigLua strings)

### File Organization
- **Module Location**: All modules in `modules/` directory
- **One Feature Per File**: Each plugin/feature gets its own .nix file
- **Naming Convention**: kebab-case for filenames (e.g., `clipboard-ssh.nix`, `render-markdown.nix`)
- **Special Files**: 
  - `_top-level.nix`: Core vim settings (opts, globals, basic config)
  - `gui-profile.nix`: GUI-specific settings (transparency, fonts, clipboard via xclip)
  - `terminal-profile.nix`: Terminal-specific settings (OSC 52 clipboard, no transparency)
  - `_cs_*.nix`: Colorscheme definitions

### Imports & Dependencies
- **Register Modules**: Add new modules to `flake.nix` imports array
  - Lines 64-95: GUI profile imports
  - Lines 132-163: Terminal profile imports (shared modules + terminal-specific)
- **Import Order**: Group logically (core → UI → LSP → tools → profile)
- **extraPackages**: Add language tools/LSPs to `extraPackages` in flake.nix (lines 26-62)

### Naming Conventions
- **Files**: kebab-case (e.g., `none-ls-format.nix`, `lsp-format.nix`)
- **Nix Attributes**: camelCase for plugin options (e.g., `plugins.neotest.settings.log_level`)
- **Keymaps**: Descriptive action strings (e.g., "Show file explorer (left)")
- **Variables**: camelCase in Lua code, snake_case acceptable for Lua functions

### Plugin Configuration Pattern
```nix
{...}: {
  plugins.pluginName = {
    enable = true;
    settings = {
      # Declarative plugin settings
      option_name = value;
    };
  };
}
```

### Key Bindings
- **Leader Key**: Space (`<leader>` = ` `)
- **Local Leader**: Tab (`<localleader>` = `<Tab>`)
- **Keymap Structure**: Use list of attribute sets in `keymaps = [ {...} {...} ]`
- **Required Fields**: `mode`, `key`, `action`
- **Options**: `options.desc` for descriptions, `options.silent = true` to suppress output
- **Avoid Conflicts**: Check `modules/keymaps.nix` before adding new bindings

### Error Handling
- **Nix Evaluation**: Errors caught at build time via `nix flake check`
- **Lua Safety**: Use `pcall()` for vim.api calls that might fail
- **Graceful Degradation**: Check platform (pkgs.stdenv.isLinux) before adding platform-specific packages
- **Diagnostics**: LSP diagnostics configured with multi-line virtual text support

## Platform & Testing

### Platform Support
- **Linux**: Full support including Jupyter/Magma integration, X11 clipboard (xclip), Wayland (wl-clipboard)
- **macOS**: Full support except Magma (disabled due to ueberzug++ dependency issues)
- **Windows**: Via WSL2 (tested and working)
- **SSH/Remote**: OSC 52 clipboard support for seamless remote development

### Clipboard Behavior
- **GUI Profile** (`gui-profile.nix`): Uses xclip (X11) or wl-clipboard (Wayland) for local clipboard
- **Terminal Profile** (`terminal-profile.nix`): Uses OSC 52 escape sequences for SSH clipboard forwarding
- **tmux Integration**: Automatically configured when running inside tmux (tmux-navigator plugin)
- **Supported Terminals**: Ghostty (recommended), Windows Terminal, iTerm2, Kitty, Alacritry
- **Testing Keymaps**: `<leader>ct` (clipboard test), `<leader>cs` (status), `<leader>tm` (tmux config)

### Test Frameworks (via neotest)
- **C#/.NET**: .NET Test, xUnit, NUnit, MSTest (via neotest-dotnet adapter)
- **Go**: Built-in testing framework (via neotest-go)
- **Java**: JUnit, TestNG (via neotest-java)
- **JavaScript/TypeScript**: Jest, Vitest (via neotest-jest, neotest-vitest)
- **Python**: pytest, unittest (via neotest-python)
- **Ruby**: RSpec (via neotest-rspec)
- **Rust**: Cargo test (via neotest-rust)
- **Zig**: Built-in testing (via neotest-zig)
- **Lua/Neovim**: plenary test suite (via neotest-plenary)

### NCrunch-Style Testing
- **Auto-Test on Save**: Tests run automatically when files are saved (watch.enabled = true)
- **Coverage Visualization**: Real-time coverage highlights with color-coded lines
  - 🟢 Green: Fully covered lines
  - 🟠 Orange: Partially covered lines
  - 🔴 Red: Uncovered lines
- **Configuration**: See `modules/testing.nix` and `modules/coverage.nix`

## Commit Standards

### Conventional Commits (Cocogitto)
- **Format**: `type(scope): description` where type is feat/fix/docs/refactor/test/chore
- **Examples**: 
  - `feat(lsp): add rust-analyzer configuration`
  - `fix(clipboard): resolve OSC 52 escaping in tmux`
  - `docs(readme): update installation instructions`
- **Configuration**: See `cog.toml` in root
- **Pre-Commit**: Run `just check` to validate formatting and build before committing

### Git Workflow
- **Before Commit**: Run `just format` and `just check` to ensure code quality
- **Commit Message**: Follow conventional commit format
- **Changelog**: Auto-generated via cocogitto
- **Bump Commits**: Enabled (disable_bump_commit = false)

## Development Workflow

### Adding a New Plugin
1. Create new file: `modules/plugin-name.nix`
2. Use module pattern: `{...}: { plugins.pluginName = { enable = true; }; }`
3. Add to `flake.nix` imports (GUI and/or terminal profile)
4. Run `just format` to format code
5. Run `just check` to validate configuration
6. Test with `just run-gui` or `just run-term`

### Modifying Existing Modules
1. Edit the module file in `modules/`
2. Run `just format` to ensure proper formatting
3. Run `just check` to validate changes
4. Test the change with `just run-gui` or `just run-term`
5. Commit with conventional commit message

### Adding Language Support
1. Add language tools to `extraPackages` in `flake.nix` (compiler, LSP, formatter)
2. Configure LSP in `modules/lsp.nix` (add to `plugins.lsp.servers`)
3. Add formatter in `modules/lsp-format.nix` or `modules/none-ls-format.nix`
4. Add neotest adapter in `modules/testing.nix` if testing support exists
5. Run `just check` to validate, then test in a project using that language

## Repository Context

### Key Files
- `flake.nix`: Main configuration entry point, defines GUI and terminal packages
- `justfile`: Task runner with common commands
- `modules/_top-level.nix`: Core vim settings (opts, globals)
- `modules/keymaps.nix`: All key bindings
- `modules/lsp.nix`: LSP server configurations (400+ lines with multi-line diagnostics)
- `modules/testing.nix`: Neotest configuration for all test frameworks
- `modules/coverage.nix`: Test coverage visualization
- `.copilot-instructions.md`: Context for GitHub Copilot Chat

### Design Philosophy
1. **Modular Design**: Each feature isolated in its own file
2. **Cross-Platform**: Works on Linux, macOS, Windows (WSL)
3. **Developer-Focused**: Optimized for coding with testing, LSP, debugging
4. **NCrunch-Style Testing**: Automatic test execution and coverage feedback
5. **Minimal Intrusion**: Copilot suggestions manual, not automatic

### Current Focus Areas
- Enhancing Copilot Chat repository awareness
- Cross-platform compatibility improvements
- Testing and coverage workflow optimization
- LSP and completion system refinements (migrated to blink-cmp from nvim-cmp)