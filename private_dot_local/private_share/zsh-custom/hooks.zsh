function preexec() {
  TIMER=${TIMER:-"$SECONDS"}
}

# called before a history line is saved.  See zshmisc(1).
function zshaddhistory() {
  LASTHIST="$@"
}

function precmd() {
  if [ $TIMER ]; then
    local elapsed_seconds=$(($SECONDS - $TIMER))
    unset TIMER
    if [ "$elapsed_seconds" -gt 60 ]; then
      notify-send "[term] ${LASTHIST} took ${elapsed_seconds}s to run"
    fi
  fi
}
