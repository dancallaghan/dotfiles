#!/bin/sh

dotfiles_dir=`dirname $0`

fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$@"
}

create_zshrc_local() {
  local_file="$HOME/.zshrc.local"
  [ -f "$local_file" ] || touch "$local_file"
}

append_to_zshrc() {
  local text="$1" zshrc
  local skip_new_line="${2:-0}"

  if [ -w "$HOME/.zshrc.local" ]; then
    zshrc="$HOME/.zshrc.local"
  else
    zshrc="$HOME/.zshrc"
  fi

  if ! grep -Fqs "$text" "$zshrc"; then
    if [ "$skip_new_line" -eq 1 ]; then
      printf "%s\n" "$text" >> "$zshrc"
    else
      printf "\n%s\n" "$text" >> "$zshrc"
    fi
  fi
}

update_shell() {
  local shell_path;
  shell_path="$(which zsh)"

  fancy_echo "Changing your shell to zsh ..."
  if ! grep "$shell_path" /etc/shells > /dev/null 2>&1 ; then
    fancy_echo "Adding '$shell_path' to /etc/shells"
    sudo sh -c "echo $shell_path >> /etc/shells"
  fi
  chsh -s "$shell_path"
}

check_shell() {
  case "$SHELL" in
    */zsh)
      if [ "$(which zsh)" != '/usr/local/bin/zsh' ] ; then
        update_shell
      fi
      ;;
    *)
      update_shell
      ;;
  esac
}

install_brew() {
  if ! command -v brew >/dev/null; then
    fancy_echo "Installing Homebrew..."
    curl -fsSL \
      'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh' | /bin/bash

    export PATH="/usr/local/bin:$PATH"
  fi

  append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1
}


append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'

#======================
# submodules
git submodule update --init --recursive


#======================
# zsh
create_zshrc_local

fancy_echo "<=> Linking: zsh config"
ln -sfv "$dotfiles_dir/zsh/zshrc" "$HOME/.zshrc"
ln -sfv "$dotfiles_dir/zsh/zimrc" "$HOME/.zimrc"

if [ ! -L "$HOME/.zim" ]; then
  ln -sfv "$dotfiles_dir/zsh/zim" "$HOME/.zim"
fi


#======================
# brew
install_brew

fancy_echo "<=> Linking: Homebrew config"
ln -sfv "$dotfiles_dir/brew/Brewfile" "$HOME"

fancy_echo "↑↑↑ Updating Homebrew formulae..."
brew update
fancy_echo "↓↓↓ Installing Homebrew bundle..."
brew bundle --file="$HOME/Brewfile"

check_shell


#======================
# git
fancy_echo "<=> Linking: git config"
ln -sfv "$dotfiles_dir/git/gitconfig" "$HOME/.gitconfig"


#======================
# vim
fancy_echo "<=> Linking: vim config"
[[ -d "$HOME/.config/nvim" ]] || mkdir -p "$HOME/.config/nvim"
ln -sfv "$dotfiles_dir/vim/vimrc" "$HOME/.vimrc"
ln -sfv "$dotfiles_dir/vim/vimrc" "$HOME/.config/nvim/init.vim"

if [ ! -L "$HOME/.config/nvim/autoload" ]; then
  ln -sfv "$dotfiles_dir/vim/vim/autoload" "$HOME/.config/nvim/autoload"
fi

if [ ! -L "$HOME/.vim" ]; then
  ln -sfv "$dotfiles_dir/vim/vim" "$HOME/.vim"
fi

nvim +PlugInstall +qall


#======================
# rbenv + nodenv
fancy_echo "↪ - Configuring rbenv and nodenv..."
append_to_zshrc 'eval "$(rbenv init - --no-rehash)"' 1
append_to_zshrc 'eval "$(nodenv init - --no-rehash)"' 1
