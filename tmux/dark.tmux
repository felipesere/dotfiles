# Reset the styles that we modify in this file
set -gu status-style
set -gu window-status-current-format
set -gu window-status-format

# 👇 this controls the actual background of the status bar
set -g status-style bg=colour236

setw -g window-status-current-format  '#[fg=black,bg=colour214] #I #[bg=colour11] #W '
setw -g window-status-format          '#[fg=colour239,bg=colour246 ] #I #[bg=colour252] #W '

set -g status-right '#[fg=colour4]#[fg=colour233,bg=colour4] %d/%m/%Y #[fg=colour7]#[fg=colour233,bg=colour7] Local %H:%M #[fg=colour12]'
