home          := home_directory()
zshrc_exists  := path_exists(home / '.zshrc')
bashrc_exists := path_exists(home / '.bashrc')

# List available recipes
default:
  @just --list

# Link dotfiles
init:
  stow . --no-folding --target={{home}}
  {{ if zshrc_exists == "false" { "ln -s " + home + "/.config/zsh/.zshrc " + home + "/.zshrc" } else { "" } }}
  {{ if bashrc_exists == "false" { "ln -s " + home + "/.config/bash/.bashrc " + home + "/.bashrc" } else { "" } }}

# Clean dotfiles
clean:
  stow -D . --no-folding --target={{home}}
  {{ if zshrc_exists == "true" { "rm " + home + "/.zshrc" } else { "" } }}
  {{ if bashrc_exists == "true" { "rm " + home + "/.bashrc" } else { "" } }}

# Relink dotfiles
restow: clean init
