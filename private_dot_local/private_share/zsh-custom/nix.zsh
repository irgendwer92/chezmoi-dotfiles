if [[ -f ~/.nix-profile/etc/profile.d/nix.sh ]]; then
  export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
  source ~/.nix-profile/etc/profile.d/nix.sh
fi
