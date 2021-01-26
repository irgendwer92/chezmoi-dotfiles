if [[ -f $(command -v yaegi) ]] && [[ -f $(command -v rlwrap) ]]; then
  alias yaegi="rlwrap yaegi"
fi
