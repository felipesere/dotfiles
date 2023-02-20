#!/usr/bin/env bash
fail() {
  >&2 echo "$1"
  exit 2
}

fzf="$(command -v fzf 2> /dev/null)" || fzf="$(dirname "$0")/fzf"
[[ -x "$fzf" ]] || fail 'fzf executable not found'

# --height option is not allowed. CTRL-Z is also disabled.
args=("--no-height" "--bind=ctrl-z:ignore")

set -e

# Clean up named pipes on exit
id=$RANDOM
argsf="${TMPDIR:-/tmp}/fzf-args-$id"
fifo1="${TMPDIR:-/tmp}/fzf-fifo1-$id"
fifo2="${TMPDIR:-/tmp}/fzf-fifo2-$id"
fifo3="${TMPDIR:-/tmp}/fzf-fifo3-$id"
cleanup() {
  \rm -f $argsf $fifo1 $fifo2 $fifo3

  if [[ $# -gt 0 ]]; then
    trap - EXIT
    exit 130
  fi
}
trap 'cleanup 1' SIGUSR1
trap 'cleanup' EXIT

envs="export TERM=$TERM "
if [[ -f ~/.fzf-theme.env ]]; then
  # This will override the style
  readarray -t args < ~/.fzf-theme.env
fi
[[ -n "$FZF_DEFAULT_COMMAND" ]] && envs="$envs FZF_DEFAULT_COMMAND=$(printf %q "$FZF_DEFAULT_COMMAND")"
echo "$envs;" > "$argsf"

# Build arguments to fzf
opts=$(printf "%q " "${args[@]}")

pppid=$$
echo -n "trap 'kill -SIGUSR1 -$pppid' EXIT SIGINT SIGTERM;" >> $argsf
close="; trap - EXIT SIGINT SIGTERM"

mkfifo -m o+w $fifo2
mkfifo -m o+w $fifo3
mkfifo $fifo1
cat <<< "\"$fzf\" $opts < $fifo1 > $fifo2; echo \$? > $fifo3 $close" >> $argsf
cat <&0 > $fifo1 &
"bash -c 'exec -a fzf bash $argsf'" > /dev/null 2>&1 || { "$fzf" "${args[@]}"; exit $?; }
cat $fifo2
exit "$(cat $fifo3)"
