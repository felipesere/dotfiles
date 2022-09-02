# Reset the styles that we modify in this file
set -u status-style
set -u window-status-current-style

# 👇 this controls the actual background of the status bar
set -g status-style bg=colour8

# 👇 this controls the active tab, fg=black is really white because Alacritty remaps the color
set -g window-status-current-style fg=black,bg=colour6

set -g status-right '#[bg=colour11,fg=black] %d/%m #[bg=colour15] @ %H:%M '
