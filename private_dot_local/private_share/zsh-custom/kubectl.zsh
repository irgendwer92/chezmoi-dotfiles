if [[ -f "$(command -v kubectl)" ]]; then
  function kubectl-apply-secret() {
    local name="$1"
    local filepath="$2"

    if [[ -z "$name" || -z "$filepath" ]]; then
      echo "kubectl-apply-secret secret-name file-path [kubectl arguments...]"
      echo "examples:"
      echo "\tkubectl-apply-secret name path/to/folder/or/file"
      echo "\tkubectl-apply-secret name path/to/folder/or/file -n foo"
      return
    fi
    shift
    shift

    kubectl create secret generic "$name" \
      --save-config --dry-run=client \
      --from-file="$filepath" \
      -o yaml \
      "$@" | kubectl apply -f -
  }

  function kubeconfig-remove() {
    if [[ -f "$KUBECONFIG" ]]; then
      rm $KUBECONFIG
      unset KUBECONFIG
    fi
  }

  alias kas="kubectl-apply-secret"
  alias kw="watch kubectl"
fi
