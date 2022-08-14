#!/usr/bin/env bash
#
# This script will first ensure nix+flakes is installed. Since we expect it to be sourced,
# note that we restore the initial directory and exit on error setting.

set -e

pushd . > /dev/null
cd "$DOTFILES/nix"

NIX_CONF=${HOME}/.config/nix/nix.conf
SOURCE_SCRIPT=${HOME}/.nix-profile/etc/profile.d/nix.sh

export NIX_INSTALLER_NO_MODIFY_PROFILE=true

if [ -e ${SOURCE_SCRIPT} ] ; then
    . ${SOURCE_SCRIPT}
fi

if ! command -v nix &> /dev/null ; then
    echo "Nix not installed. Installing nix..."
    bash -c "$(curl --fail -L https://nixos.org/nix/install)" # single-user install
    echo "Sourcing ${SOURCE_SCRIPT}..."
    . ${SOURCE_SCRIPT}
    nix-env --version
    echo "Nix installed! Configuring flakes..."
    touchp $NIX_CONF
    echo "experimental-features = nix-command flakes" >> $NIX_CONF
    echo "auto-optimise-store = true" >> $NIX_CONF
    echo "keep-outputs = true" >> $NIX_CONF
    echo "virtualisation.docker.enable = true" >> $NIX_CONF
    echo "allowUnfree = true" >> $NIX_CONF
    echo "Nix + flakes installed and ready for use!"
fi

# Turn off error setting so it won't affect the nix shell
set +e
is-nix-shell || nix develop

popd > /dev/null
