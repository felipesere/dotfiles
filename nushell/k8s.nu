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

def --wrapped kg [
  resource?: string,
  name?: string,
  ...rest,
] {
  let actual_resource = if $resource == null {
    kubectl api-resources | from ssv -a | sk --format { get name } | get name
  } else {
    $resource
  }

  # If name not provided, get it via skim
  let data = if $name == null {
    kubectl get $actual_resource ...$rest
  } else {
    kubectl get $actual_resource $name ...$rest
  }

  $data | from ssv | update "AGE" {|row| $row.AGE | parse_age $in }
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

def parse_age [age: string] {
  $age
  | parse --regex '(?<days>\d+d)?(?<hours>\d+h)?(?<minutes>\d+m)?(?<seconds>\d+s)?'
  | update "days" {|r| $r.days | str replace 'd' 'day' | into duration}
  | update "hours" {|r| $r.hours | str replace 'h' 'hr' | into duration }
  | update "minutes" {|r| $r.minutes | str replace 'm' 'min' | into duration }
  | update "seconds" {|r| $r.seconds | str replace 's' 'sec' | into duration }
  | each {|row| $row.days + $row.hours + $row.minutes + $row.seconds}
  | get 0
}

# kubectl
alias k  =  kubectl

# kubectl get
alias kga = kg all
alias kgp = kg pod
alias kgc = kg cm
alias kgsec = kg secret
alias kgd = kg deploy
alias kgrs = kg rs
alias kgj = kg job
alias kgcj = kg cj
alias kgs = kg service
alias kgn = kg node
alias kgsm = kg servicemonitor

# kubectl describe
alias kdn = kd node
alias kdp = kd pod
alias kdc = kd cm
alias kdsec = kd secret
alias kdd = kd deploy
alias kdrs = kd rs
alias kdj = kd job
alias kdcj = kd cj
alias kds = kd service
alias kdsm = kd servicemonitor

# ky - fzf kubectl yaml prettifier
alias kyp = ky pod
alias kyc = ky cm
alias kysec = ky secret
alias kyd = ky deploy
alias kyrs = ky rs
alias kyj = ky job
alias kycj = ky cj
alias kysm = ky sm
alias kys = ky service
alias kysa = ky sa
alias kyn = ky node
alias kyh = ky hpa
