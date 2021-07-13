if [[ -f $(command -v pygmentize) ]]; then
  function pyglex() {
    pygmentize -l "$1"
  }
fi
