if [[ -f $(command -v kitty) ]]; then
  alias icat="kitty +kitten icat"
  alias ssh="TERM=xterm-256color ssh"
fi
