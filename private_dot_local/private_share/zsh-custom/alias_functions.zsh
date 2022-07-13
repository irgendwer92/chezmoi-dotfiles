###
# suffix aliases
###
alias -s git="git clone"

###
# aliases
###
alias date-iso="date --utc +%FT%T.%3NZ"
alias fuck="sudo !!"
alias copy="xsel -bi"
alias pasta="xsel -bo"

alias ssh-keygen-to-stdout="echo /tmp/stderr{,.pub} | xargs -n 1 ln -sf /dev/stderr && yes | ssh-keygen -t ed25519 -N '' -qf /tmp/stderr > /dev/null"

###
# functions
###

function auropen() { gio open "https://aur.archlinux.org/packages/$1" }

# get and show external network ip
function get-ext-ip() {
	echo "$(curl -s https://ip.werise.de)"
}

###
## SSL
###

# show lifetime of an https certificate
function test-ssl-cert-lifetime {
    echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -noout -dates
}

# download https certificate
function get-ssl-cert {
    echo | openssl s_client -connect $1:443 -servername $1 -prexit 2>/dev/null | sed -n -e '/BEGIN\ CERTIFICATE/,/END\ CERTIFICATE/ p'
}

# download mp3
function download-mp3 {
    youtube-dl -x --audio-format mp3 "$1"
}
