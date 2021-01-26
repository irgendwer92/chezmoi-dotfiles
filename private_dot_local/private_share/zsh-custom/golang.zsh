# configure golang environment

if [[ -d "/usr/local/go" ]] then;
  export PATH="$PATH:/usr/local/go/bin"
fi

if [[ -f "$(command -v go)" ]] then;
  export GOPATH="$HOME/go"
  export PATH="$PATH:$GOPATH/bin"
  export GO111MODULE=on
fi
