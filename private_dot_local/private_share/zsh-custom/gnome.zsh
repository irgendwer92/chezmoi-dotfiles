alias gnome-settings-backup='dconf dump / > "$(chezmoi source-path)/ignored/included/dconf.ini"'
alias gnome-settings-restore='dconf load / < "$(chezmoi source-path)/ignored/included/dconf.ini"'
