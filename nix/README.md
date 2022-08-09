# Nix Package Manager

## Setup
Your shell should automatically install, configure, and launch nix by sourcing the [use-nix.sh](./use-nix.sh) script.

## Packages
The [flake.nix](./flake.nix) file defines the packages to be installed. See what's available at https://search.nixos.org/packages.

After making package changes, restart your shell OR exit the nix shell and run `nix develop`.

## Misc
```bash
# You'll need to occasionally garbage collect:
nix-store --gc
```