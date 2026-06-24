# Nix + Home Manager dotfiles

This directory contains a full [home-manager](https://github.com/nix-community/home-manager)
conversion of the dotfiles previously managed with GNU Stow.

## Structure

```
nix/
├── flake.nix          # Entry point — pins nixpkgs + home-manager
├── home.nix           # Root home-manager config (imports all modules)
├── modules/
│   ├── packages.nix   # All installed packages (replaces manual apt/pip installs)
│   ├── fonts.nix      # Nerd Fonts + CJK fonts
│   ├── git.nix        # git identity, aliases
│   ├── zsh.nix        # zsh + oh-my-zsh + direnv
│   ├── starship.nix   # Starship prompt
│   ├── neovim.nix     # Neovim + vim-plug plugins + custom ftplugin files
│   ├── alacritty.nix  # Alacritty terminal (Eighties Dark theme)
│   ├── kitty.nix      # Kitty terminal (used by lf for image preview)
│   ├── sway.nix       # Sway WM + Waybar + Wofi + Gammastep + GTK theme
│   ├── dunst.nix      # Dunst notification daemon
│   ├── lf.nix         # lf file manager + image preview scripts
│   └── misc.nix       # Everything else: zathura, rofi, i3 fallback,
│                      #   cursor themes, wallpapers, local scripts, …
└── system/            # System-level configs (require root, not managed by home-manager)
    ├── setup.sh       # Deploy script — run once after fresh install (sudo)
    ├── gdm/           # GDM login screen: monitors.xml (laptop-only layout)
    ├── cpupower/      # CPU governor: powersave, 800MHz–4.0GHz
    ├── intel_turbo_boost/  # systemd service: disable Intel turbo boost
    ├── lightdm/       # lightdm primary-display-only helper script
    └── xorg.conf.d/   # Intel DRI/TearFree + libinput rules (X11/i3 fallback)
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

## System-level setup (one-time, requires root)

Some configs live outside `$HOME` and cannot be managed by home-manager.
They are kept in `nix/system/` and deployed by a single script:

```bash
sudo bash nix/system/setup.sh
```

This handles all sections in one go. To deploy only specific parts:

```bash
sudo bash nix/system/setup.sh gdm           # GDM monitor layout + tweaks
sudo bash nix/system/setup.sh cpupower      # CPU governor config
sudo bash nix/system/setup.sh turbo-boost   # Disable Intel turbo boost service
sudo bash nix/system/setup.sh xorg          # X11 Intel + libinput config (i3 fallback)
```

### What each section does

| Section | Files deployed | Notes |
|---------|---------------|-------|
| `gdm` | `gdm/monitors.xml` → `/var/lib/gdm/.config/` | Restricts GDM to laptop screen (`eDP-1`); also runs `gsettings` as the gdm user to enable tap-to-click and scale font to 1.25× |
| `cpupower` | `cpupower/etc/default/cpupower` → `/etc/default/cpupower` | Powersave governor, 800 MHz–4.0 GHz; restarts the `cpupower` service if enabled |
| `turbo-boost` | `intel_turbo_boost/.../disable-turbo-boost.service` → `/etc/systemd/system/` | Installs and enables a systemd service that writes `1` to `/sys/devices/system/cpu/intel_pstate/no_turbo` on boot |
| `xorg` | `xorg.conf.d/` → `/usr/share/X11/xorg.conf.d/` | Intel DRI/TearFree driver config + libinput touchpad (tap, natural scroll) — only needed for X11/i3 sessions |
