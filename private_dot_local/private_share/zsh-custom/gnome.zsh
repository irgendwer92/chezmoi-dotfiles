alias gnome-settings-backup="dconf dump / > \"$(chezmoi source-path)/ignored_files/dconf.ini\""
alias gnome-settings-restore="dconf load / < \"$(chezmoi source-path)/ignored_files/dconf.ini\""
