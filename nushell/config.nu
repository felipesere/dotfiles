$env.config = {
  show_banner: false
}

use ~/.dotfiles/starship/starship.nu

alias nvim = vim

def --env dots [] {
  cd ~/.dotfiles
}

def font_size [size] {
  open ~/.alacritty-font-size.toml | update font.size $size | to toml | save -f ~/.alacritty-font-size.toml
}

def laptop [] { font_size 16 }
def normal [] { font_size 24 }
def presentatation [] { font_size 32 }

def kc [
  cluster?: string,
  --unset (-u) # clear the current kubernetes context
] {
  match [$unset, $cluster] {
    [true, _] => {
      kubectl config unset current-context
    },
    [ _  , null] => {
      let c = kubectl config get-contexts | from ssv --aligned-columns | input list --fuzzy --display NAME | get NAME
      kubectl config use-context $c
    },
    [ _  , $namedCluster] => {
      kubectl config use-context $namedCluster
    }
  }
}
 
def kg [] { kubectl get }

def kns [
  namespace?: string,
] {
  let ctx = (kubectl config current-context)

  let ns = match $namespace {
    null => {
      kubectl get ns
                | from ssv --aligned-columns
                | input list "Pick a namespace: " --fuzzy --display NAME
                | get NAME
    },
    $n => $n
  }

  kubectl config set $"contexts.($ctx).namespace" $ns
}
