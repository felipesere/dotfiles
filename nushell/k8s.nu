alias k = kubectl

alias kg = kubectl get

def kc [ clear?: string ] {
  if $clear == null {
    kubectl config get-contexts
      | from ssv -a
      | sk --format { get name }
      | get name
      | kubectl config use-context $in
  } else {
    kubectl config unset current-context
  }
}

def kns [ namespace?: string ] {
  let ctx = kubectl config current-context
  let ns = if $namespace == null {
    kubectl get namespaces
      | from ssv -a
      | sk --format { get name }
      | get name
  } else {
    $namespace
  }
  kubectl config set $"contexts.($ctx).namespace" $ns
}

def ky [ resource?: string, name?: string ] {
  let actual_resource = if $resource == null {
    kubectl api-resources | from ssv -a | sk --format { get name } | get name
  } else {
    $resource
  }

  # If name not provided, get it via fzf
  let actual_name = if $name == null {
    kubectl get $actual_resource | from ssv -a | sk --format  { get name } | get name
  } else {
    $name
  }

  kubectl get $actual_resource $actual_name -oyaml | bat -l=yaml --plain
}

def kd [resource?: string, name?: string] {
    # If resource not provided, get it via fzf
    let actual_resource = if $resource == null {
      kubectl api-resources | from ssv -a | sk --format { get name } | get name
    } else {
      $resource
    }

    # If name not provided, get it via fzf
    let actual_name = if $name == null {
      kubectl get $actual_resource | from ssv -a | sk --format  { get name } | get name
    } else {
      $name
    }

    # Execute the kubectl describe command
    kubectl describe $actual_resource $actual_name
}
