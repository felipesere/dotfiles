alias k = kubectl

alias kg = kubectl get

def kd [resource?: string, name?: string] {
    # If resource not provided, get it via fzf
    let actual_resource = if $resource == null {
        kubectl api-resources --no-headers | lines | each { |line| $line | split row ' ' | first } | fzf
    } else {
        $resource
    }
    
    # If name not provided, get it via fzf
    let actual_name = if $name == null {
        kubectl get $actual_resource --no-headers | lines | each { |line| $line | split row ' ' | first } | fzf
    } else {
        $name
    }
    
    # Execute the kubectl describe command
    kubectl describe $actual_resource $actual_name
}

# function kd() {
#   local -r resource="${1:-$(kubectl api-resources --no-headers | choose 0 | fzf)}"
#   local -r name="${2:-$(kubectl get "${resource}" --no-headers | choose 0 | fzf)}"
#   kubectl describe "${resource}" "${name}"
# }
