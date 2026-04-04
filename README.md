# Neovim Config — External Dependencies

## Required CLI Tools

| Tool | Purpose |
|------|---------|
| `ripgrep` (rg) | Live grep / project search |
| `fd` | File finder |
| `git` | Git signs, diffs, history |
| `lazygit` | Git TUI |
| `lazydocker` | Docker TUI |
| `sqlit` | Database TUI |
| `gcc` or `clang` | Compile Treesitter parsers |

## Fonts

A **Nerd Font** is required — the config uses Nerd Font icons throughout.
Grab one from [nerdfonts.com](https://www.nerdfonts.com) and set it as your terminal font.

## Mason Language Dependencies

Mason installs LSPs, formatters, and linters automatically, but requires the
following languages/runtimes to be available in PATH:

| Runtime | Required for |
|---------|-------------|
| `node` / `npm` | Most LSPs (vtsls, cssls, tailwindcss, jsonls, intelephense, svelte, vue) + PHP debug adapter |
| `go` | gopls, delve debugger, golangci-lint, goimports, gofumpt |
| `python` / `pip` | basedpyright, black |
| `php` / `composer` | intelephense, phpstan, pint, php-cs-fixer |
| `cargo` (Rust) | Some Mason packages are distributed as Rust binaries |
| `java` / `javac` | nvim-java plugin |

> You only need the runtimes for languages you actually develop in.
> Run `:checkhealth mason` to verify what Mason can see.
