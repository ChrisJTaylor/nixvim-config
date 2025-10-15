# Nixvim Config

A comprehensive Neovim configuration built with nixvim, featuring modern development tools, extensive language support, and NCrunch-style continuous testing.

## 🚀 Key Features

### **Testing & Coverage (NCrunch-like Experience)**
- **Auto-test-on-save** for all supported languages
- **Real-time coverage visualization** with inline highlights
- **Comprehensive language support**: C#/.NET, Go, Python, Ruby, Rust, Java, JavaScript/TypeScript, Zig
- **Interactive test panel** with neotest integration
- **Automatic coverage reload** after test completion

### **Language Support & LSP**
- Full LSP integration with `lspsaga` for enhanced UI
- Intelligent code completion with `blink-cmp`
- Advanced syntax highlighting with `treesitter`
- EditorConfig-aware formatting via `none-ls` and `lsp-format` (Prettier for JS/TS, shfmt for shell, alejandra for Nix; OmniSharp formats C#).
- GitHub Copilot integration for AI-assisted coding

## 🧰 Formatting & EditorConfig

- Format on save: Enabled for LSP and none-ls sources.
- EditorConfig: Respected for indent, EOL, final newline, trimming.
- JS/TS: Prettier via none-ls (prettierd); tsserver formatting disabled to avoid conflicts. Prettier resolves config/plugins from your project. Ensure `prettier` and any plugins are in `devDependencies`.
- C#: OmniSharp handles formatting and respects .editorconfig; csharpier is disabled.
- Shell: shfmt with defaults `-i 2 -sr -bn` (switch to 4 spaces if preferred).
- Nix: alejandra formats Nix files.

### **File Management & Navigation**
- **Neo-tree** file explorer with git integration
- **Telescope** fuzzy finder for files, symbols, and more
- **Frecency** algorithm for intelligent file suggestions
- **LazyGit** terminal integration

### **Developer Experience**
- **Smart cursor** with `smear-cursor` animations
- **Auto-save** functionality
- **Render markdown** preview
- **Vimwiki** for note-taking
- **Timerly** time tracking integration
- **Magma** Jupyter notebook support (Linux only)

## 📋 Prerequisites
- Nix with flakes enabled
- Git
- Basic terminal knowledge

## 🖥️ Platform Support
- ✅ **Linux**: Full support including Jupyter/Magma integration
- ✅ **macOS**: Full support (Magma disabled due to ueberzug dependency)
- ✅ **Windows**: Via WSL2

## 🛠️ Installation & Usage

### Quick Try
```bash
# Try without installing
nix run github:ChrisJTaylor/nixvim-config

# Build locally
nix build .

# Run locally
nix run .
```

### Permanent Installation
```bash
# Install to profile
nix profile install .

# Or add to your flake configuration
inputs.nixvim-config.url = "github:ChrisJTaylor/nixvim-config";
home.packages = [ inputs.nixvim-config.packages.${system}.default ];
```

## ⌨️ Key Mappings

### **File Explorer & Navigation**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ef` | `:Neotree filesystem reveal` | Open file explorer |
| `<leader>efl` | `:Neotree filesystem reveal left` | File explorer (left) |
| `<leader>efr` | `:Neotree filesystem reveal right` | File explorer (right) |
| `<leader>eb` | `:Neotree buffers reveal` | Show open buffers |
| `<leader>eg` | `:Neotree git_status reveal` | Show git changes |

### **Testing & Coverage** 
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ts` | `:Neotest summary` | Show test panel |
| `<leader>tr` | `run all tests` | Run all tests in project |
| `<leader>tf` | `run file tests` | Run tests in current file |
| `<leader>tn` | `run nearest test` | Run test under cursor |
| `<leader>tl` | `run last test` | Re-run last test |
| `<leader>tw` | `toggle watch` | Auto-run tests on save |
| `<leader>td` | `debug test` | Debug nearest test |
| `<leader>to` | `:Neotest output` | Show test output |

### **Coverage Visualization**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ll` | `:CoverageLoad` | Load coverage data |
| `<leader>ls` | `:CoverageShow` | Show coverage highlights |
| `<leader>lm` | `:CoverageSummary` | Display coverage summary |
| `<leader>lt` | `:CoverageToggle` | Toggle coverage display |
| `<leader>mc` | Coverage toggle | Quick coverage toggle |
| `<leader>mx` | Coverage summary | Quick coverage summary |

### **LSP & Code Navigation**
| Key | Action | Description |
|-----|--------|-------------|
| `K` | `:Lspsaga hover_doc` | Show documentation |
| `<leader>k` | `:Lspsaga hover_doc` | Show documentation |
| `<leader>K` | `:Lspsaga hover_doc ++keep` | Show documentation (keep open) |
| `<leader>a` | `:Lspsaga code_action` | Show code actions |
| `<leader>f` | `:Lspsaga finder ref` | Find references |
| `<leader>F` | `:Lspsaga finder def+ref+imp` | Find definitions/references/implementations |

### **Git Integration**
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gg` | `:LazyGit` | Open LazyGit |

### **AI Assistant (Copilot)**

**🔧 Enhanced Repository Awareness**: Copilot Chat is configured with full repository context including:
- **GPT-4o model** for better understanding and responses
- **Automatic workspace detection** for repository context
- **File pattern inclusion** (*.nix, *.md, flake.*, justfile, etc.)
- **`.copilot-instructions.md`** with project-specific context
- **Manual context refresh** if workspace changes

**💡 Suggestions**: Inline suggestions are disabled by default to avoid intrusive completions, but can be enabled on-demand.

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>cc` | `:CopilotChat` | Open Copilot chat (full repo context) |
| `<leader>ce` | `:CopilotChatExplain` | Explain selected code |
| `<leader>cf` | `:CopilotChatFix` | Fix selected code |
| `<leader>cd` | `:CopilotChatDocs` | Generate documentation |
| `<leader>cr` | `:CopilotChatReview` | Review code |
| `<leader>crf` | `:CopilotChatRefresh` | Refresh repository context |
| `<leader>co` | `:CopilotChatOptimize` | Optimize code |
| `<leader>ct` | `:CopilotChatTests` | Generate tests |
| `<leader>cm` | `:CopilotChatCommit` | Generate commit message |
| `<leader>cs` | Toggle auto-suggestions | Enable/disable inline suggestions |
| `<C-Space>` | Manual suggestion trigger | Trigger suggestion in insert mode |

#### **Chat Panel Controls**
When in the Copilot Chat panel:

| Key | Mode | Action | Description |
|-----|------|--------|-------------|
| `<ESC>` | Insert | Close chat panel | Dismisses the entire chat panel |
| `<C-c>` | Insert | Exit insert mode | Leave insert mode (stay in panel) |
| `<Enter>` | Normal | Submit prompt | Send your message to Copilot |
| `<C-s>` | Insert | Submit prompt | Send your message to Copilot |
| `<C-l>` | Both | Reset chat | Clear current conversation |
| `<C-y>` | Both | Accept diff | Apply suggested code changes |
| `q` | Normal | Close chat panel | Dismisses the entire chat panel |
| `gd` | Normal | Show diff | View suggested changes |
| `gi` | Normal | Show info | Display chat information |
| `gc` | Normal | Show context | View current context files |

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
| `t` | `:Lspsaga term_toggle` | Toggle floating terminal |
| `<ESC>` | `:nohlsearch` | Clear search highlights |

## 🧪 Auto-Testing Features

The configuration provides NCrunch-style continuous testing:

- **Automatic test execution** when saving files
- **Real-time coverage updates** after tests complete
- **Visual feedback** with inline coverage highlights
- **Support for multiple test frameworks** per language

### Supported Languages & Frameworks
- **C#**: .NET Test, xUnit, NUnit, MSTest
- **Go**: Built-in testing framework
- **Python**: pytest, unittest
- **Ruby**: RSpec
- **Rust**: Cargo test
- **Java**: JUnit, TestNG
- **JavaScript/TypeScript**: Jest, Vitest
- **Zig**: Built-in testing

## 🎨 UI Enhancements

- **Syntax highlighting** with treesitter
- **Icons** with devicons
- **Smooth cursor** animations
- **Floating windows** for LSP actions
- **Coverage highlights** in three colors:
  - 🟢 **Green**: Covered lines
  - 🟡 **Purple**: Partially covered
  - 🔴 **Red**: Uncovered lines

## 📚 Further Reading
- [Nixvim documentation](https://nix-community.github.io/nixvim/index.html)
- [NixOS](https://nixos.org/)
- [Nix first steps](https://nix.dev/tutorials/first-steps/)

---
**Leader key**: `<Space>`  
**Local leader**: `<Tab>`
