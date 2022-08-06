#!/bin/sh
#
# bootstrap script to install/sync dotfiles into target directory
# Usage: ./boostrap.sh [destination=HOME]

cd "$(dirname "$0")"
DOTFILES_ROOT=$(pwd -P)
LINK_DST="${1:-$HOME}"

set -e

echo ''


info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

# If .gitconfig filled with placeholders, prompt user for git name/email
setup_gitconfig () {
  if grep -q AUTHORNAME git/.gitconfig.symlink ; then
    info 'setup gitconfig with name/email'

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -I '' -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" git/.gitconfig.symlink > /dev/null

    success 'gitconfig'
  fi
}

link_symlink_files () {
  info 'linking .symlink files'

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink') ; do
    local dst="$LINK_DST/$(basename ${src%.*})"
    ln -sf "$src" "$dst"
    success "linked $src to $dst"
  done
}

#########################################################################################

setup_gitconfig
link_symlink_files

echo ''
echo '  All installed!'
