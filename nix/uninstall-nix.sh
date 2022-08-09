#!/bin/sh
#
# Uninstall nix. Mostly

rm -rf $HOME/{.nix-channels,.nix-defexpr,.nix-profile,.config/nixpkgs}
sudo rm -rf /nix

echo 'Remove the . "$HOME/.nix-profile/etc/profile.d/nix.sh" line in your ~/.profile or ~/.bash_profile, if present'