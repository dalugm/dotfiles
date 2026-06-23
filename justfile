# List available recipes
default:
  @just --list

# Initialize chezmoi and apply dotfiles
init:
  chezmoi init --apply

# Apply dotfiles
apply:
  chezmoi apply -v

# Edit a file with chezmoi
edit target:
  chezmoi edit {{target}}

# Add a file to chezmoi
add target:
  chezmoi add {{target}}

# Show diff between source and target
diff:
  chezmoi diff

# Show status
status:
  chezmoi status

# Update dotfiles from remote
update:
  chezmoi update -v

# Enter chezmoi source directory
cd:
  chezmoi cd

# Remove a file from chezmoi management
forget target:
  chezmoi forget {{target}}

# Re-add all managed files
re-add:
  chezmoi re-add