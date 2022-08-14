#!/usr/bin/env bash
#
# This script will first ensure nix+flakes is installed. Since we expect it to be sourced,
# note that we restore the initial directory and exit on error setting.

set -e

pushd . > /dev/null
cd "$DOTFILES/nix"

SOURCE_SCRIPT=${HOME}/.nix-profile/etc/profile.d/nix.sh
NIX_CONF=${HOME}/.config/nix/nix.conf
NIXPKGS_CONF=${HOME}/.config/nixpkgs/config.nix

# Source nix.sh
if [ -e ${SOURCE_SCRIPT} ] ; then
    . ${SOURCE_SCRIPT}
fi

# Install nix as required
if ! command -v nix &> /dev/null ; then
    echo "Nix not installed. Installing nix..."
    export NIX_INSTALLER_NO_MODIFY_PROFILE=true
    bash -c "$(curl --fail -L https://nixos.org/nix/install)" # single-user install
    echo "Sourcing ${SOURCE_SCRIPT}..."
    . ${SOURCE_SCRIPT}
    nix-env --version
    echo "Nix installed!"
fi

# Use latest config files
touchp $NIXPKGS_CONF && cat config.nix >| $NIXPKGS_CONF
touchp $NIX_CONF && cat nix.conf >| $NIX_CONF

# Launch nix shell (turning off error setting so it won't exit on error)
set +e
is-nix-shell || nix develop

popd > /dev/null
