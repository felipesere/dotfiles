# Reset the styles that we modify in this file
set -gu status-style
set -gu window-status-current-style

# 👇 this controls the actual background of the status bar
set -g status-style bg=colour236

# 👇 this controls the active tab, fg=white is really black because Alacritty remaps the color
set -g window-status-current-style fg=black,bg=colour167

set -g status-right '#[fg=colour233,bg=colour4] %d/%m #[fg=colour233,bg=colour12] Local %H:%M #[fg=colour239]'
