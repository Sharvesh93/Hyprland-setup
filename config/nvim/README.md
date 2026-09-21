# Modern Neovim Configuration (Arch Linux + Hyprland + Kitty)

A minimal, fast, modular, transparent Neovim setup designed for high productivity and aesthetic integration with Kitty and Hyprland.

---

## Architecture & Layout

```text
~/.config/nvim/
├── init.lua                   # Entry point (bootstraps lazy.nvim, sets leaders & PATH)
├── lua/
│   ├── config/
│   │   ├── options.lua        # General Neovim settings (numbers, tabs, search, undo)
│   │   ├── keymaps.lua        # Core keybindings
│   │   ├── autocmds.lua       # Auto-commands (highlight on yank, window resize)
│   │   └── transparency.lua   # Transparency engine enforcing bg = "none"
│   ├── generated/
│   │   └── colors.lua         # Matugen wallpaper color integration
│   └── plugins/
│       ├── colorscheme.lua    # TokyoNight (transparent) with Matugen accents
│       ├── ui.lua             # Transparent lualine, bufferline, which-key, icons
│       ├── treesitter.lua     # Syntax highlighting & incremental selection
│       ├── telescope.lua      # Fuzzy finder with transparent floating window
│       ├── lsp.lua            # Mason, Mason-lspconfig, Nvim-lspconfig, Fidget
│       ├── completion.lua     # Nvim-cmp, LuaSnip, friendly-snippets, lspkind
│       ├── editor.lua         # Neo-tree, Conform formatting, Autopairs, ToggleTerm
│       └── git.lua            # Gitsigns & LazyGit integration
└── README.md                  # Documentation & keymap guide
```

---

## Transparency Guarantee

The terminal background from Kitty remains 100% visible through Neovim.
- All primary surfaces (`Normal`, `NormalNC`, `SignColumn`, `LineNr`, `EndOfBuffer`) are transparent.
- Floating windows (`NormalFloat`, `FloatBorder`) have transparent bodies with rounded borders.
- Telescope, Which-Key, Neo-Tree, Completion menus, and Lualine all use transparent backgrounds (`bg = "none"`).
- Automatically re-applies on any `ColorScheme` or `UIEnter` event.

---

## Keybindings Reference (<leader> = Space)

### General & Windows
| Keybinding | Action |
| :--- | :--- |
| `<leader>w` / `<C-s>` | Save current file |
| `<leader>q` | Quit current window |
| `<leader>Q` | Force quit all |
| `<Esc>` | Clear search highlights |
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Navigate window splits |
| `<leader>sv` / `<leader>sh` | Split window vertically / horizontally |
| `<leader>sx` | Close current split |

### File Explorer & Buffers
| Keybinding | Action |
| :--- | :--- |
| `<leader>e` | Toggle file explorer (Neo-tree) |
| `<leader>o` | Focus file explorer |
| `<Tab>` / `]b` | Next buffer |
| `<S-Tab>` / `[b` | Previous buffer |
| `<leader>bd` | Delete current buffer |
| `<leader>bo` | Close all other buffers |

### Fuzzy Finding (Telescope)
| Keybinding | Action |
| :--- | :--- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep across project (ripgrep) |
| `<leader>fb` | Find open buffers |
| `<leader>fr` | Recent files (oldfiles) |
| `<leader>fs` | Document symbols |
| `<leader>ft` | Find TODO / NOTE comments |
| `<leader>fc` | Browse Neovim config files |

### LSP & Code Intelligence
| Keybinding | Action |
| :--- | :--- |
| `gd` | Go to Definition |
| `gD` | Go to Declaration |
| `gi` | Go to Implementation |
| `gr` | Find References (Telescope) |
| `K` | Hover documentation |
| `<leader>ca` | Code Action |
| `<leader>rn` | Rename symbol |
| `<leader>cf` / `<leader>fm` | Format code (Conform / LSP) |
| `[d` / `]d` | Previous / Next diagnostic |
| `<leader>ld` | Floating line diagnostics |

### Git & Terminal
| Keybinding | Action |
| :--- | :--- |
| `<leader>gg` | Open LazyGit in floating window |
| `<leader>gb` | Git blame current line |
| `<leader>gp` | Preview git hunk |
| `<leader>gs` / `<leader>gr` | Stage / Reset git hunk |
| `[h` / `]h` | Previous / Next git hunk |
| `<leader>tt` / `<C-\>` | Toggle floating terminal |
