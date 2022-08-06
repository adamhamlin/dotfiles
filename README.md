# adam does dotfiles

>NOTE: This is a WIP!!!

This was includenced by https://github.com/holman/dotfiles.

## design

There are a few special directories...

- **shell/**: All files required for your particular shell. Currently uses bash.
- **nix/**: Contains a `flake.nix` file to configure/install packages for your environment. See [README](./nix/README.md).
- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **public-keys/**: Public keys you want to make available anywhere.

All other directories are **"topics"**, corresponding to specific programs/packages/etc. These files are processed/synced by running the `./bootstrap` script.

- **{topic}/\*.symlink**: Any file ending in `*.symlink` will be symlinked into
  your `$HOME` directory.
  >_Note this will overwrite an existing file with the same name._
- **{topic}/\*.sh**: Any files ending in `.sh` get executed by your shell. For example, you might want to export applicable environment variables here.


## use it

```bash
git clone https://github.com/adamhamlin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap
# restart your shell
```
>_After changes to `~/.dotfiles`, re-run the bootstrap script again to re-sync your environment._

## todo
- clean up bootstrap process/waterfall/nix/etc
- different script for bootstrap vs re-sync?
- figure out auto-completion paradigm