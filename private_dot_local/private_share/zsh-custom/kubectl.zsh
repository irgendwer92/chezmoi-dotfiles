if [[ -d $HOME/.kube ]]; then
  if [[ ! -v KUBECONFIG ]]; then
    list=($HOME/.kube/confi{g,gs/*})
    joined=$(export IFS=":"; echo "${list[*]}")
    export KUBECONFIG="${joined}"
  fi
fi
