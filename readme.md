# Nixvim Config

Neovim configuration with NCrunch-style continuous testing, GitHub Copilot integration, and comprehensive language support.

## ⚡ Key Highlights

- **🧪 NCrunch-style testing**: Auto-test-on-save with real-time coverage visualization (🟢 covered, 🟠 partial, 🔴 uncovered)
- **🤖 GitHub Copilot**: GPT-4o with resource-based context system (`#glob:**/*.py`, `@copilot` for tool access)
- **📋 SSH Clipboard Support**: Robust OSC 52 integration for seamless copy/paste over SSH (works with Ghostty, Windows Terminal, iTerm2)
- **🌐 Multi-language**: C#/.NET, Go, Python, Ruby, Rust, Java, JavaScript/TypeScript, Zig
- **⚙️ Smart formatting**: EditorConfig-aware with Prettier, OmniSharp, alejandra, shfmt

## 🚀 Quick Start

```bash
# Try without installing
nix run github:ChrisJTaylor/nixvim-config

# Install to profile
nix profile install .
```

## 🛠️ Installation Options

```bash
# Build locally
nix build .

# Run locally
nix run .

# Or add to your flake configuration
inputs.nixvim-config.url = "github:ChrisJTaylor/nixvim-config";
home.packages = [ inputs.nixvim-config.packages.${system}.default ];
```

---

## 📖 Feature Deep Dive

### 🧪 Testing & Coverage Features

**NCrunch-style continuous testing** with:
- **Automatic test execution** when saving files
- **Real-time coverage updates** with color-coded highlights:
  - 🟢 **Green**: Fully covered lines
  - 🟠 **Orange**: Partially covered lines
  - 🔴 **Red**: Uncovered lines
- **Interactive test panel** with neotest integration
- **Multi-framework support** per language

**Supported Languages & Frameworks**:
- **C#**: .NET Test, xUnit, NUnit, MSTest
- **Go**: Built-in testing framework
- **Python**: pytest, unittest
- **Ruby**: RSpec
- **Rust**: Cargo test
- **Java**: JUnit, TestNG
- **JavaScript/TypeScript**: Jest, Vitest
- **Zig**: Built-in testing

### 🤖 GitHub Copilot Integration

**Advanced AI Assistant** with:
- **GPT-4o model** for enhanced understanding
- **Resource-based context system**: `#glob:**/*.py`, `#buffer:active`, `#gitdiff:staged`
- **Tool access**: `@copilot` enables AI to use search, edit, and bash commands
- **Multi-language examples**: Works with Python, Rust, Go, JavaScript, C#, Java, etc.
- **Project-specific context** via `.copilot-instructions.md`

### 📋 Clipboard & Remote Development

**Seamless Remote Experience**:
- **SSH Support**: Uses OSC 52 escape sequences to communicate directly with your local terminal clipboard.
- **Platform Agnostic**: Works whether you are on Linux, macOS, or Windows (via WSL2).
- **Tmux Integration**: Automatic configuration when running inside tmux.

### 🧰 Language Support & Formatting

**EditorConfig-aware formatting**:
- **JS/TS**: Prettier via none-ls (prettierd); tsserver formatting disabled
- **C#**: OmniSharp handles formatting and respects .editorconfig
- **Shell**: shfmt with defaults `-i 2 -sr -bn`
- **Nix**: alejandra formats Nix files
- **Format on save**: Enabled for LSP and none-ls sources

**Core Features**:
- Full LSP integration with `lspsaga` enhanced UI
- Intelligent completion with `blink-cmp`
- Advanced syntax highlighting with `treesitter`
- Neo-tree file explorer with git integration
- Telescope fuzzy finder with frecency algorithm

---

## ⌨️ Keybinding Reference

### **AI Assistant (Copilot)**

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>cc` | `:CopilotChat` | **Open Copilot chat** |
| `<leader>ca` | `:CopilotChatOpen` | Open chat with project context |
| `<leader>cR` | `:CopilotChatRefresh` | **Refresh repository context** |
| `<leader>cT` | `Toggle auto-trigger` | **Toggle auto-trigger** |
| `<leader>cs` | `:CopilotChatSave` | Save chat history |
| `<leader>ct` | `:CopilotChatTests` | Generate tests |
| `<leader>cr` | `:CopilotChatReview` | Review code |
| `<leader>ci` | `:CopilotChatContext` | Show resource syntax help |
| `<leader>cp` | `:CopilotChatProjectOverview` | Project overview with context |
| `<leader>cA` | `:CopilotChatCodeAnalysis` | Analyze codebase for improvements |
| `<leader>cH` | `:CopilotChatProjectHelp` | Project structure help |
| `<leader>ce` | `:CopilotChatExplain` | Explain selected code |
| `<leader>cf` | `:CopilotChatFix` | Fix selected code |
| `<leader>cd` | `:CopilotChatDocs` | Generate documentation |
| `<leader>co` | `:CopilotChatOptimize` | Optimize code |
| `<leader>cm` | `:CopilotChatCommit` | Generate commit message |
| `<C-Space>` | Manual suggestion trigger | Trigger suggestion in insert mode |

### **Clipboard (SSH & Local)**

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>y` | `OSC52 Copy` | **Copy to system clipboard** (SSH supported) |
| `<leader>p` | `OSC52 Paste` | **Paste from system clipboard** (SSH supported) |
| `<leader>yt` | `Test Clipboard` | Test clipboard configuration |
| `<leader>ys` | `Clipboard Status` | Show clipboard provider status |

### **Testing & Coverage**

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ts` | `:Neotest summary` | Show test panel |
| `<leader>tr` | `run all tests` | Run all tests in project |
| `<leader>tf` | `run file tests` | Run tests in current file |
| `<leader>tn` | `run nearest test` | Run test under cursor |
| `<leader>tl` | `run last test` | Re-run last test |
| `<leader>tw` | `toggle watch` | **Auto-run tests on save** |
| `<leader>td` | `debug test` | Debug nearest test |
| `<leader>to` | `:Neotest output` | Show test output |
| `<leader>ll` | `:CoverageLoad` | **Load coverage data** |
| `<leader>ls` | `:CoverageShow` | Show coverage highlights |
| `<leader>lm` | `:CoverageSummary` | Display coverage summary |
| `<leader>lt` | `:CoverageToggle` | Toggle coverage display |
| `<leader>mc` | Coverage toggle | Quick coverage toggle |
| `<leader>mx` | Coverage summary | Quick coverage summary |

### **File Explorer & Navigation**

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ef` | `:Neotree filesystem reveal` | **Open file explorer** |
| `<leader>efl` | `:Neotree filesystem reveal left` | File explorer (left) |
| `<leader>efr` | `:Neotree filesystem reveal right` | File explorer (right) |
| `<leader>eb` | `:Neotree buffers reveal` | Show open buffers |
| `<leader>eg` | `:Neotree git_status reveal` | Show git changes |

### **LSP & Code Navigation**

| Key | Action | Description |
|-----|--------|-------------|
| `K` | `:Lspsaga hover_doc` | **Show documentation** |
| `<leader>k` | `:Lspsaga hover_doc` | Show documentation |
| `<leader>K` | `:Lspsaga hover_doc ++keep` | Show documentation (keep open) |
| `<leader>a` | `:Lspsaga code_action` | **Show code actions** |
| `<leader>f` | `:Lspsaga finder ref` | **Find references** |
| `<leader>F` | `:Lspsaga finder def+ref+imp` | Find definitions/references/implementations |

### **Git Integration**

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gg` | `:LazyGit` | **Open LazyGit** |

### **Window Management**

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>\|` | `<C-w><C-v>` | Split vertically |
| `<leader>-` | `<C-w><C-s>` | Split horizontally |
| `<leader>w` | `<C-w><C-w>` | Switch windows |
| `<C-h/j/k/l>` | Move focus | Navigate between windows |

### **Utilities**

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>q` | `:q!` | Quit without saving |
| `<leader>m` | `:marks` | List all marks |
| `<leader>tm` | `:TimerlyToggle` | Toggle time tracking |
| `<leader>rr` | Telescope refactoring | Show refactoring options |
| `t` | `:Lspsaga term_toggle` | **Toggle floating terminal** |
| `<ESC>` | `:nohlsearch` | Clear search highlights |

### 📚 Resources
- [Nixvim documentation](https://nix-community.github.io/nixvim/index.html)
- [NixOS](https://nixos.org/)
- [Nix first steps](https://nix.dev/tutorials/first-steps/)
