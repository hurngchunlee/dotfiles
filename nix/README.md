# Nix + Home Manager dotfiles

This directory contains a full [home-manager](https://github.com/nix-community/home-manager)
conversion of the dotfiles previously managed with GNU Stow.

## Structure

```
nix/
├── flake.nix          # Entry point — pins nixpkgs + home-manager
├── home.nix           # Root home-manager config (imports all modules)
└── modules/
    ├── packages.nix   # All installed packages (replaces manual apt/pip installs)
    ├── fonts.nix      # Nerd Fonts + CJK fonts
    ├── git.nix        # git identity, aliases
    ├── zsh.nix        # zsh + oh-my-zsh + direnv
    ├── starship.nix   # Starship prompt
    ├── neovim.nix     # Neovim + vim-plug plugins + custom ftplugin files
    ├── alacritty.nix  # Alacritty terminal (Eighties Dark theme)
    ├── kitty.nix      # Kitty terminal (used by lf for image preview)
    ├── sway.nix       # Sway WM + Waybar + Wofi + Gammastep + GTK theme
    ├── dunst.nix      # Dunst notification daemon
    ├── lf.nix         # lf file manager + image preview scripts
    └── misc.nix       # Everything else: zathura, rofi, i3 fallback,
                       #   cursor themes, wallpapers, local scripts, …
```

## Prerequisites

- [Nix](https://nixos.org/download/) with flakes enabled
- [home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone)
  installed as a standalone tool (not NixOS)

Enable flakes in `~/.config/nix/nix.conf` (or `/etc/nix/nix.conf`):

```
experimental-features = nix-command flakes
```

## First-time activation

```bash
# From the repo root
cd nix/
nix run home-manager/master -- switch --flake .#honlee
```

On subsequent runs:

```bash
home-manager switch --flake ~/dotfiles/nix#honlee
```

## Updating inputs

```bash
cd nix/
nix flake update          # bump nixpkgs + home-manager to latest
home-manager switch --flake .#honlee
```

## Design decisions

| Topic | Choice |
|-------|--------|
| Prompt | Starship (invoked manually in `initExtra` so oh-my-zsh theme is left blank) |
| oh-my-zsh | Managed by `programs.zsh.oh-my-zsh`; `zsh-syntax-highlighting` plugin is loaded via it |
| Vim plugins | Declared via `programs.neovim.plugins`; vim-plug is no longer needed |
| Non-Nix packages | Anaconda/conda and Environment Modules (HPC) are detected at runtime and loaded only if present at their system paths |
| Raw file carry-over | Configs without a home-manager module (rofi themes, ranger, cursor themes, i3 fallback, scripts) are copied verbatim via `home.file` pointing into the adjacent `packages/` tree |
| i3 / X11 fallback | All i3 + picom + rofi + redshift configs are still deployed via `misc.nix` for use in Xorg sessions |

## Username / home directory

If you are deploying for a different user, edit `home.nix`:

```nix
home.username = "your-username";
home.homeDirectory = "/home/your-username";
```

and update the `homeConfigurations` key in `flake.nix` to match.
