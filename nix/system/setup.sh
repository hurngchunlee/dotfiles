#!/usr/bin/env bash
# =============================================================================
# nix/system/setup.sh
#
# Deploys system-level configs that cannot be managed by home-manager because
# they require root or target paths outside $HOME.
#
# Run this once after a fresh install, or re-run to update any of the files.
#
# Usage:
#   sudo bash nix/system/setup.sh [section...]
#
# Sections (run all if none specified):
#   gdm             GDM login screen monitor layout + tweaks
#   cpupower        CPU governor / frequency limits
#   turbo-boost     systemd service to disable Intel turbo boost
#
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
info()    { echo "[info]  $*"; }
success() { echo "[ok]    $*"; }
warn()    { echo "[warn]  $*"; }

require_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "[error] This script must be run as root (sudo)." >&2
        exit 1
    fi
}

deploy_file() {
    local src="$1" dst="$2"
    local dst_dir
    dst_dir="$(dirname "$dst")"
    mkdir -p "$dst_dir"
    cp "$src" "$dst"
    success "$(basename "$src") -> $dst"
}

# -----------------------------------------------------------------------------
# Section: GDM
# Deploys the monitor layout so GDM uses only the laptop screen at login,
# then applies tap-to-click and font scaling inside the gdm user session.
# -----------------------------------------------------------------------------
setup_gdm() {
    info "--- GDM ---"

    local monitors_src="$SCRIPT_DIR/gdm/monitors.xml"
    local monitors_dst="/var/lib/gdm/.config/monitors.xml"

    deploy_file "$monitors_src" "$monitors_dst"
    chown gdm:gdm "$monitors_dst"

    # Apply gsettings tweaks as the gdm user.
    # machinectl is the clean way but requires systemd; fall back to su.
    info "Applying GDM gsettings (tap-to-click, font scaling)..."
    if command -v machinectl &>/dev/null && machinectl status gdm &>/dev/null 2>&1; then
        machinectl shell gdm@ /bin/bash -c "
            gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click 'true'
            gsettings set org.gnome.desktop.interface text-scaling-factor '1.25'
        "
    else
        warn "machinectl not available or gdm not running; running gsettings via su."
        su -s /bin/bash gdm -c "
            export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u gdm)/bus
            gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click 'true'
            gsettings set org.gnome.desktop.interface text-scaling-factor '1.25'
        " || warn "gsettings failed — you may need to run gdm/setup.sh manually as the gdm user."
    fi

    success "GDM setup complete."
}

# -----------------------------------------------------------------------------
# Section: CPUpower
# Sets the CPU governor to powersave with a defined frequency range.
# Requires the cpupower service to be enabled.
# -----------------------------------------------------------------------------
setup_cpupower() {
    info "--- CPUpower ---"
    deploy_file "$SCRIPT_DIR/cpupower/etc/default/cpupower" "/etc/default/cpupower"
    if systemctl is-enabled cpupower &>/dev/null; then
        systemctl restart cpupower
        success "cpupower service restarted."
    else
        warn "cpupower service not enabled; enable it with: systemctl enable --now cpupower"
    fi
    success "CPUpower setup complete."
}

# -----------------------------------------------------------------------------
# Section: Intel turbo boost
# Installs and enables a systemd service that disables CPU turbo boost on boot.
# -----------------------------------------------------------------------------
setup_turbo_boost() {
    info "--- Intel turbo boost ---"
    local service_src="$SCRIPT_DIR/intel_turbo_boost/etc/systemd/system/disable-turbo-boost.service"
    local service_dst="/etc/systemd/system/disable-turbo-boost.service"
    deploy_file "$service_src" "$service_dst"
    systemctl daemon-reload
    systemctl enable --now disable-turbo-boost.service
    success "Turbo boost service installed and enabled."
}

# -----------------------------------------------------------------------------
# Main
# -----------------------------------------------------------------------------
require_root

SECTIONS=("$@")
if [[ ${#SECTIONS[@]} -eq 0 ]]; then
    SECTIONS=(gdm cpupower turbo-boost)
fi

for section in "${SECTIONS[@]}"; do
    case "$section" in
        gdm)          setup_gdm ;;
        cpupower)     setup_cpupower ;;
        turbo-boost)  setup_turbo_boost ;;
        *)
            echo "[error] Unknown section: $section" >&2
            echo "        Valid sections: gdm cpupower turbo-boost" >&2
            exit 1
            ;;
    esac
done

info "All requested sections deployed."
