#!/bin/bash
set -euo pipefail

VERSION=12.0.2
URL="https://github.com/qarmin/czkawka/releases/download/$VERSION/linux_czkawka_cli_arm64"
# GitHub release asset digest; verify before executing any downloaded code.
SHA256=3a65408ca30036cf1cd993112bde6288e13c870842d12131dee8b4e435325c38
BIN_DIR="${DPKG_ROOT:-}/opt/dslideshow/bin"
TARGET="$BIN_DIR/czkawka_cli"
LINK="${DPKG_ROOT:-}/usr/local/bin/czkawka_cli"
LINK_TARGET=../../../opt/dslideshow/bin/czkawka_cli
TEMP_DIR=
STAGE=prepare
RESULT=failed
START=$SECONDS

log()
{
    local level=$1
    shift
    local message="component=czkawka-install operation=$$ version=$VERSION $* duration=$((SECONDS - START))s"
    logger -s -p "syslog.$level" -t dslideshow.deb -- "$message" || printf '%s\n' "$message" >&2
}

cleanup()
{
    local status=$?
    trap - EXIT
    if [ -n "$TEMP_DIR" ]; then
        rm -rf -- "$TEMP_DIR"
    fi
    if [ "$status" -ne 0 ]; then
        if [ "$RESULT" = cancelled ]; then
            log info "action=$STAGE result=cancelled"
        else
            log err "action=$STAGE result=failed exit=$status"
        fi
    fi
    exit "$status"
}
trap cleanup EXIT
trap 'RESULT=cancelled; exit 130' INT
trap 'RESULT=cancelled; exit 143' TERM
trap 'RESULT=cancelled; exit 129' HUP

checksum_matches()
{
    printf '%s  %s\n' "$SHA256" "$1" | sha256sum --check --status
}

log info 'action=install result=started'
install -d -m 0755 -- "$BIN_DIR" "${LINK%/*}"

# Preserve commands installed by the administrator or another package.
STAGE=link-conflict
if [ -e "$LINK" ] || [ -L "$LINK" ]; then
    [ -L "$LINK" ] && [ "$(readlink -- "$LINK")" = "$LINK_TARGET" ] || exit 1
fi

if [ -f "$TARGET" ] && [ ! -L "$TARGET" ] && checksum_matches "$TARGET"; then
    STAGE=reuse
    chmod 0755 "$TARGET"
    timeout 10 "$TARGET" --version >/dev/null 2>&1
    log info 'action=reuse result=verified'
else
    STAGE=download
    TEMP_DIR=$(mktemp -d "$BIN_DIR/.czkawka-install.XXXXXX")
    CANDIDATE="$TEMP_DIR/czkawka_cli"
    log info 'action=download result=started'
    curl --fail --location --silent --show-error \
        --proto '=https' --proto-redir '=https' \
        --connect-timeout 20 --max-time 60 \
        --retry 2 --retry-delay 2 --retry-max-time 180 \
        --output "$CANDIDATE" "$URL"
    STAGE=checksum
    checksum_matches "$CANDIDATE"
    chmod 0755 "$CANDIDATE"
    STAGE=runtime
    # Also reject incompatible architectures, missing libraries and loader errors.
    timeout 10 "$CANDIDATE" --version >/dev/null 2>&1
    STAGE=replace
    mv -fT -- "$CANDIDATE" "$TARGET"
fi

STAGE=link
if [ ! -L "$LINK" ]; then
    ln -s -- "$LINK_TARGET" "$LINK"
fi
log info 'action=install result=completed'
