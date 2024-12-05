alias k = kubectl

alias kg = kubectl get

def kd [resource?: string name?: string] {
  let r = match $resource {
    null => (kubectl api-resources | from ssv | select NAME | sort | input list -f "Select resource")
    $res => $res
  }
  let n = match $name {
    null => (kubectl get $r --no-headers | from )

  }
}

kd() {
  local -r resource="${1:-$(kubectl api-resources --no-headers | choose 0 | fzf)}"
  local -r name="${2:-$(kubectl get "${resource}" --no-headers | choose 0 | fzf)}"
  kubectl describe "${resource}" "${name}"
}
