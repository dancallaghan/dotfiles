#!/bin/sh

dotfiles_dir=`cd -- "$(dirname $0)" > /dev/null 2>&1; pwd -P`
echo $dotfiles_dir

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
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    export PATH="/usr/local/bin:$PATH"
  fi

  append_to_zshrc 'export PATH="/usr/local/bin:$PATH"' 1
}

install_zim() {
  if [ ! -d "$HOME/.zim" ]; then
    fancy_echo "Installing zim..."
    curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh
  fi

  zsh ~/.zim/zimfw.zsh install
}

append_to_zshrc 'export PATH="$HOME/.bin:$PATH"'


#======================
# zsh
create_zshrc_local

fancy_echo "<=> Linking: zsh config"
stow zsh
stow zim
install_zim


#======================
# brew
install_brew

fancy_echo "↑↑↑ Updating Homebrew formulae..."
brew update
fancy_echo "↓↓↓ Installing Homebrew bundle..."
brew bundle --file="$dotfiles_dir/brew/Brewfile"

check_shell


#======================
# git
fancy_echo "<=> Linking: git config"
stow git


#======================
# vim
fancy_echo "<=> Linking: neovim config"
stow nvim


#======================
# kitty
fancy_echo "<=> Linking: kitty config"
stow kitty


#======================
# ctags
fancy_echo "<=> Linking: ctags config"
stow ctags


#======================
# rbenv + nodenv
fancy_echo "↪ - Configuring rbenv and nodenv..."
append_to_zshrc 'eval "$(rbenv init - --no-rehash)"' 1
append_to_zshrc 'eval "$(nodenv init - --no-rehash)"' 1
