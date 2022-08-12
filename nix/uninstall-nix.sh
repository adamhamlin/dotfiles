#!/usr/bin/env bash
#
# Uninstall nix. Mostly for dev/test purposes.

rm -rf $HOME/{.nix-channels,.nix-defexpr,.nix-profile,.config/nixpkgs}
sudo rm -rf /nix

echo 'Remove the . "$HOME/.nix-profile/etc/profile.d/nix.sh" line in your ~/.profile or ~/.bash_profile, if present'