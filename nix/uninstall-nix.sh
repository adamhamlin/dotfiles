#!/usr/bin/env bash
#
# Uninstall nix. Mostly for dev/test purposes.
# NOTE: If NIX_INSTALLER_NO_MODIFY_PROFILE was not set, need to remove the . "$HOME/.nix-profile/etc/profile.d/nix.sh"
#       line in your ~/.profile or ~/.bash_profile
rm -rf $HOME/{.nix-channels,.nix-defexpr,.nix-profile,.config/nixpkgs,.config/nix}
sudo rm -rf /nix
