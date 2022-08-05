# Nix Package Manager

## Install (multi-user)
```bash
sh <(curl -L https://nixos.org/nix/install)
```

Add the following to `~/.config/nix/nix.conf`:
```bash
experimental-features = nix-command flakes # enable flakes
auto-optimise-store = true # try to save space by reducing duplicate files with sym links
```
The [flake.nix](./flake.nix) file will define the packages to be installed.
>_See what's available at https://search.nixos.org/packages_

## Use nix environment
```bash
nix develop
```
## Misc
```bash
# You'll need to occasionally garbage collect:
nix-store --gc
```