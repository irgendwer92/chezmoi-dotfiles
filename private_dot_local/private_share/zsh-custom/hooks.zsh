# function preexec() {
#   timer=${timer:-$SECONDS}
# }
# 
# function precmd() {
#   if [ $timer ]; then
#     timer_show=$(($SECONDS - $timer))
#     export RPROMPT="RT: %F{cyan}${timer_show}s %{$reset_color%} UTC: %F{grey}$(date --utc +%FT%T.%3NZ)%{$reset_color%}"
#     unset timer
#   fi
# }
