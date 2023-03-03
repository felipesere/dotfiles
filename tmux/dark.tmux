# Reset the styles that we modify in this file
set -gu status-style
set -gu window-status-current-style

# 👇 this controls the actual background of the status bar
set -g status-style bg=colour8

# 👇 this controls the active tab, fg=white is really black because Alacritty remaps the color
set -g window-status-current-style fg=white,bg=colour4

set -g status-right '#[fg=colour233,bg=colour4] %d/%m #[fg=colour233,bg=colour10] Local %H:%M | Eirik: #(TZ="Asia/Bangkok" date +%%H:%%M) #[fg=colour239]'
