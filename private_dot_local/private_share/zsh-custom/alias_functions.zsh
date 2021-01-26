###
# suffix aliases
###
alias -s git="git clone"

###
# aliases
###
alias open-ssh-show-tunnel="ssh -nNT -R 3001:localhost:3000 show.werise.de &"
alias date-iso="date --utc +%FT%T.%3NZ"
alias create-nvmrc="node --version | tr -d 'v' > .nvmrc"
# alias ping="prettyping"
alias docker-for-mac-enter="docker run -it --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i sh"
alias flush-memcached="echo 'flush_all' | nc localhost 11211"
alias vim="nvim"
alias vimdiff="nvim -d"
alias fuck="sudo !!"
alias copy="xsel -bi"
alias pasta="xsel -bo"
alias termbin="nc termbin.com 9999"

# fzf-preview jq on all json files
alias fzf-jq="echo '' | fzf --print-query --preview 'cat *.json | jq {q}'"

# start ipython shell in current venv
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# remove ansi color data from piped data
alias stripcolors='sed "s/\x1B\[\([0-9]\{1,2\}\(;[0-9]\{1,2\}\)\?\)\?[mGK]//g"'

alias ssh-keygen-to-stdout="echo /tmp/stderr{,.pub} | xargs -n 1 ln -sf /dev/stderr && yes | ssh-keygen -t ed25519 -N '' -qf /tmp/stderr > /dev/null"

function ssh-keys-from-github() {
	for user in "$@"
	do
		echo "# `date` GitHub Keys for user '$user':"
		curl -qs "https://github.com/$user.keys"
	done
}

###
# functions
###

function mount-ubuntu-legacy-root() {
	sudo cryptsetup open /dev/nvme0n1p3 old-crypt
	# lol: mount: /mnt/dev/old-crypt: special device /dev/ubuntu-vg/root does not exist.
	sleep 5
	sudo mount /dev/ubuntu-vg/root /mnt/dev/old-crypt
}

###
## GUI
###

# run a gui command in bg from the terminal witouth seeing stdout and stderr
function run-gui() {
	$1>/dev/null 2>&1 &
}

###
## NETWORKING
###

# get and show external network ip
function get-ext-ip() {
	echo "$(curl -s https://ip.werise.de)"
}

# fzf *.ovpn files in current folder, select one and start ovpn with it
function openvpn-select-config() {
	find . -name "*.ovpn" | fzf |
		while IFS= read -r line; do
			sudo xargs openvpn --config "$line"
		done
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

###
## MEDIA
###

# download mp3
function download-mp3 {
    youtube-dl -x --audio-format mp3 "$1"
}

###
## NODE/NPM
###

# usage: npm-publish <newversion>|major|minor|patch|premajor|preminor|prepatch|prerelease
function npm-publish(){
  npm version $1 && \
    git push --follow-tags && \
    npm publish
}

###
###
###
# MIGRATION
###

function backup-packages() {
	CURRENT_PATH=$(pwd)
	MIGRATION_PATH="$HOME/Nextcloud/migration/mac_$(date +"%Y%m%d_%H%M%S")"
	mkdir -p "$MIGRATION_PATH"
	cd "$MIGRATION_PATH"
	echo "saving brew packages (cli)"
	brew list > brew_list
	echo "saving brew cask packages (apps)"
	brew cask list >  brew_cask_list
	echo "saving mac app store packages"
	mas list > mas_list
	cd "$CURRENT_PATH"
}

function install-packages() {
	CURRENT_PATH=$(pwd)
	MIGRATION_PATH="$1"
	cd "$MIGRATION_PATH"
	echo "installing brew packages (cli)"
	cat brew_list | xargs -I "{}" brew install {}
	echo "installing brew cask packages (apps)"
	cat brew_cask_list | xargs -I "{}" brew cask install {}
	echo "installing mac app store packages"
	cat mas_list | cut -d " " -f 1 | xargs -I "{}" mas install {}
}


#######################
## LOODSE/KUBERMATIC ##
#######################
function k8c-cluster() {
	TMP_KUBECONFIG=$(mktemp)
	local cluster="$(kubectl get cluster | _inline_fzf | awk '{print $1}')"
	kubectl get secret admin-kubeconfig -n cluster-$cluster -o go-template='{{ index .data "kubeconfig" }}' | base64 -d > $TMP_KUBECONFIG
	KUBECONFIG=$TMP_KUBECONFIG $SHELL
}


