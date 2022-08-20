# Nix Package Manager

## Setup
Your shell should automatically install, configure, and launch `nix` + `home-manager` when it sources the [use-nix.sh](./use-nix.sh) script.
>_NOTE: This currently employs the single-user install._

## Packages
The [home.nix](./home.nix) file defines the packages to be installed (plus some other configuration items). See what packages are available at https://search.nixos.org/packages.

## Making Changes
```bash
# Sync environment with home.nix updates
home-manager switch
```

## Misc
```bash
# You'll need to occasionally garbage collect:
nix-store --gc
```