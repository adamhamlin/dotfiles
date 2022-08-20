#!/usr/bin/env bash
#
# This script will first ensure nix + home-manager are installed.

set -e
pushd . > /dev/null
cd "$DOTFILES/nix"

SOURCE_SCRIPT=${HOME}/.nix-profile/etc/profile.d/nix.sh
NIX_CONF=${HOME}/.config/nix/nix.conf
HOME_NIX=${HOME}/.config/nixpkgs/home.nix

# Set up NIX_PATH for home-manager
export NIX_PATH=$HOME/.nix-defexpr/channels

# Source nix.sh if exists
if [ -e ${SOURCE_SCRIPT} ] ; then
    . ${SOURCE_SCRIPT}
fi

# Install nix as required
if ! command -v nix &> /dev/null ; then
    # Symlink the config files
    touchp $NIX_CONF && ln -sf $PWD/nix.conf $NIX_CONF
    touchp $HOME_NIX && ln -sf $PWD/home.nix $HOME_NIX

    echo "Nix not installed. Installing nix..."
    echo
    export NIX_INSTALLER_NO_MODIFY_PROFILE=true
    bash -c "$(curl --fail -L https://nixos.org/nix/install)" # single-user install
    echo "Sourcing ${SOURCE_SCRIPT}..."
    . ${SOURCE_SCRIPT}
    nix-env --version
    echo "Nix installed!"
    echo "Installing home manager..."
    echo
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
    home-manager --version
    echo "Home manager installed!"
    echo
fi

# This script will be sourced, so restore directory/error flags
popd > /dev/null
set +e
