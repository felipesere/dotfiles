# Requires a couple of tools to be installed
#
# kubectl
# choose
# jq
# fzf
# gum (for delete)

kc() {
  if [[ "$1" == "clear" || "$1" == "unset" ]]; then
    kubectl config unset current-context
  else
    # Relies on KUBECONFIG set to colon delimeted list of all kubeconfigs ^
    # Exclude fqdn contexts (rancher-ism).
    kubectl config use-context "$(kubectl config get-contexts -o name | grep -v fqdn | fzf)"
  fi
}

# namespace switcher
kns() {
  local -r ctx="$(kubectl config current-context)"
  local ns="$1"
  if [[ "$ns" == "" ]]; then
    ns="$(kg ns | choose 0 | tail -n +2 | fzf)"
  fi
  kubectl config set "contexts.$ctx.namespace" "$ns"
}

# streamlined yaml viewer (tons of aliases for it in .aliases)
ky() {
  local -r resource="${1:-$(kubectl api-resources --no-headers | choose 0 | fzf)}"
  local -r name="${2:-$(kubectl get "${resource}" --no-headers | choose 0 | fzf)}"
  kubectl get "${resource}" "${name}" -oyaml | bat -l=yaml --plain
}

# same thing for describe
kd() {
  local -r resource="${1:-$(kubectl api-resources --no-headers | choose 0 | fzf)}"
  local -r name="${2:-$(kubectl get "${resource}" --no-headers | choose 0 | fzf)}"
  kubectl describe "${resource}" "${name}"
}

# log helper that lets you complete container name (if more than one)
kl() {
  local -r name="${1:-$(kubectl get pod --no-headers | choose 0 | fzf)}"
  container_names=$(kubectl get "pod/${name}" -o=jsonpath='{.spec.containers[*].name}' | tr -s ' '  '\n')
  if [[ "$(echo $container_names | wc -l)" = 1 ]]; then
    container="$(echo $container_names | choose 0 )" # use first container
  else
    container="$(echo "${container_names}" | sort | fzf)" # user choice
  fi
  kubectl logs -f "pod/${name}" -c "${container}"
}

# helper to delete resources
kx() {
  local -r resource="${1:-$(kubectl api-resources --no-headers | choose 0 | fzf)}"
  local -r name="${2:-$(kubectl get "${resource}" --no-headers | choose 0 | fzf)}"

  gum confirm "Delete ${resource}/${name} ?" && kubectl delete ${resource}/${name}
}

ke() {
  local -r resource="${1:-$(kubectl api-resources --no-headers | choose 0 | fzf)}"
  local -r name="${2:-$(kubectl get "${resource}" --no-headers | choose 0 | fzf)}"

  kubectl events --for ${resource}/${name}
}

kn() {
  kubectl get node | choose 0:1 | column -s " " -t | sort | fzf --header-lines=1 | choose 0
}

pods_per_node() {
  kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=$(kn)
}


alias kxp="kx pod"


# kubectl
alias k="kubectl"
alias kg="kubectl get"
alias kgy="kubectl get -oyaml"

# kubectl get
alias kga="kg all"
alias kgp="kg pod"
alias kgc="kg cm"
alias kgsec="kg secret"
alias kgd="kg deploy"
alias kgrs="kg rs"
alias kgj="kg job"
alias kgcj="kg cj"
alias kgs="kg service"
alias kgn="kg node"
alias kgsm="kg servicemonitor"

# kubectl describe
alias kdn="kd node"
alias kdp="kd pod"
alias kdc="kd cm"
alias kdsec="kd secret"
alias kdd="kd deploy"
alias kdrs="kd rs"
alias kdj="kd job"
alias kdcj="kd cj"
alias kds="kd service"
alias kdsm="kd servicemonitor"

# ky - fzf kubectl yaml prettifier
alias kyp="ky pod"
alias kyc="ky cm"
alias kysec="ky secret"
alias kyd="ky deploy"
alias kyrs="ky rs"
alias kyj="ky job"
alias kycj="ky cj"
alias kysm="ky sm"
alias kys="ky service"
alias kysa="ky sa"
alias kyn="ky node"
alias kyh="ky hpa"


# port-forward to a service by selecting a ports json entry
kpfs() {
  local -r service="${1:-$(kubectl get service --no-headers | choose 0 | fzf)}"
  local -r spec="$(kubectl get service "${service}" -ojson | jq ".spec")"
  if [ "$(echo "${spec}" | jq ".ports[]" -Mc | wc -l)" -gt 1 ]; then
    portjson="$(echo "${spec}" | jq ".ports[]" -Mc | fzf --header='pick a port object')"
  else
    portjson="$(echo "${spec}" | jq ".ports[0]" -Mc)"
  fi
  local -r port="$(echo "${portjson}" | jq ".port" -r)"
  echo "Forwarding to svc/${service}:${port} via local 8000"
  kubectl port-forward "svc/${service}" "8000:${port}"
}

# port-forward to a pod by selecting a ports entry from a ports entry
# will pick ports from the only container, or let you pick container by name
kpfp() {
  local -r pod="${1:-$(kubectl get pod --no-headers | choose 0 | fzf)}"
  local -r data="$(kubectl get pod "${pod}" -ojson)"
  if [[ "$(echo "${data}" | jq '.spec.containers | length')" = 1 ]]; then
    container="$(echo "${data}" | jq ".spec.containers[0].name" -r)"
  else
    # TODO: respect kubectl.kubernetes.io/default-container if set?
    container="$(echo "${data}" | jq ".spec.containers[].name" -r | fzf --header='mutliple containers; please pick one')" # user choice
  fi
  datajson="$(echo "${data}" | jq ".spec.containers[] | select(.name==\"${container}\")")"
  if [[ "$(echo "${datajson}" | jq ".ports")" == "null" ]]; then
    echo "No ports for $(tput bold)${container}$(tput sgr0) container in $(tput bold)${pod}$(tput sgr0)"
    return 1
  fi
  if [ "$(echo "${datajson}" | jq ".ports[]" -Mc | wc -l)" -gt 1 ]; then
    portjson="$(echo "${datajson}" | jq ".ports[]" -Mc | fzf --header="pick a port object")"
  else
    portjson="$(echo "${datajson}" | jq ".ports[0]" -Mc)"
  fi
  port="$(echo "${portjson}" | jq ".containerPort" -r)"
  echo "Forwarding to pod/${pod}:${port} via local 8000"
  kubectl port-forward "${pod}" "8000:${port}"
}

podversion() {
  local -r pod="$(kubectl get pod --no-headers | choose 0 | fzf)"

  container_names=$(kubectl get "pod/${pod}" -o=jsonpath='{.spec.containers[*].name}' | tr -s ' '  '\n')
  if [[ "$(echo $container_names | wc -l)" = 1 ]]; then
    container="$(echo $container_names | choose 0 )" # use first container
  else
    container="$(echo "${container_names}" | sort | fzf)" # user choice
  fi

  local -r image=$(kubectl get pods/"$pod" -o jsonpath="{.spec.containers[?(@.name == \"$container\")].image}")

  local grey='\e[2m'
  local blue='\e[34m'
  local green='\e[32m'
  local reset='\e[0m'
  local registry=$(echo $image | sd  '(.*)/.*' '$1')
  local img=$(echo $image | sd '.*/(.*):.*' '$1')
  local version=$(echo $image | sd '.*:(.*)' '$1')
  echo -e "$grey$registry$reset/$green$img$reset:$blue$version$reset"
}
