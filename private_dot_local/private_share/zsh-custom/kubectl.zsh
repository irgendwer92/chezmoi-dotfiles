if [[ -f $(command -v kubectl) ]]; then
  function kubectl-apply-secret() {
    kubectl create secret generic "$1" \
      --save-config --dry-run=client \
      --from-file="$2" \
      -o yaml | kubectl apply -f -
  }

  alias kw="watch kubectl"
  alias kas="kubectl-apply-secret"
fi
