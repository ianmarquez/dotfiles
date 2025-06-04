#!/bin/bash

ensure_directory() {
  local dir_path="$1"

  if [ -z "$dir_path" ]; then
    echo "Error: No directory path provided to ensure_directory function."
    return 1
  fi

  if [ ! -d "$dir_path" ]; then
    echo "Directory does not exist. Creating: $dir_path"
    mkdir -p "$dir_path"
  else
    echo "Directory already exists: $dir_path"
  fi
}

create_symlink_if_not_exists() {
    local source_dir="$1"
    local target_dir="$2"

    # Check if both parameters are provided
    if [ -z "$source_dir" ] || [ -z "$target_dir" ]; then
        echo "Usage: create_symlink_if_not_exists <source_dir> <target_dir>"
        return 1
    fi

    # Remove trailing slash from source_dir if present
    source_dir="${source_dir%/}"

    # Check if the target already exists and is a symlink
    if [ -L "$target_dir" ]; then
        echo "Symlink already exists: $target_dir"
        return 0
    fi

    # Check if the target exists but is not a symlink
    if [ -e "$target_dir" ]; then
        echo "Target already exists and is not a symlink: $target_dir"
        return 1
    fi

    # Create the symbolic link
    ln -s "$source_dir" "$target_dir"
    echo "Symlink created: $target_dir -> $source_dir"
}


# Example usage:
# create_symlink_if_not_exists "/path/to/source" "/path/to/symlink"


create_symlink_if_not_exists "$HOME/Desktop/repos/dotfiles/config/nvim" "$HOME/.config/nvim"

create_symlink_if_not_exists "$HOME/Desktop/repos/dotfiles/config/btop" "$HOME/.config/btop"

create_symlink_if_not_exists "$HOME/Desktop/repos/dotfiles/config/ghostty" "$HOME/.config/ghostty"

create_symlink_if_not_exists "$HOME/Desktop/repos/dotfiles/config/git" "$HOME/.config/git"
