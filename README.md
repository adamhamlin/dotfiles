# adam does dotfiles

This was influenced by https://github.com/holman/dotfiles.

## design

There are a few special directories...

- **shell/**: All files required for your particular shell. Currently using bash.
- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **nix/**: Contains a `flake.nix` file to configure/install packages for your environment. See [README](./nix/README.md).
- **public-keys/**: Public keys you want to make available anywhere.

All other directories are **"topics"**, corresponding to specific programs/packages/etc. These files are processed/synced by running the `./bootstrap` script.

- **{topic}/\*.symlink**: Any file ending in `*.symlink` will be symlinked into
  your `$HOME` directory.
  >_Note this will overwrite an existing file with the same name._
- **{topic}/\*.source**: Any files ending in `.source` get sourced by your shell. For example, you might want to export applicable environment variables or set up auto-completion.

## prerequisites
We're using `nix` for package management, but there are some specific requirements to even install nix. Ensure your system has the following before proceeding:
- `sudo` _(and your user has sudo access)_
- `git`
- `curl`
- `xz`

## use it

```bash
git clone https://github.com/adamhamlin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap
# restart/reset your shell
exec $SHELL
```
>_Changes to .source files or existing .symlink files should be reflected on next shell reset, but other changes may require you to re-run the bootstrap script._

## todo

- More mac vs linux switches
- One-time setup install scripts? i.e., separate from shell sourcing?