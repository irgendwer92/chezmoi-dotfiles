if [[ -f $(which yaegi) ]] && [[ -f $(which rlwrap) ]]; then
  alias yaegi="rlwrap yaegi"
fi
