# Reset the styles that we modify in this file
set -gu status-style
set -gu window-status-current-format
set -gu window-status-format

# 👇 this controls the actual background of the status bar
set -g status-style bg=colour236

setw -g window-status-current-format  '#[fg=colour16,bg=colour8] #I #[bg=colour12] #W '
setw -g window-status-format          '#[fg=colour233,bg=colour238 ] #I #[bg=colour240] #W '

set -g status-right '#[fg=colour4]#[fg=colour233,bg=colour4] %d/%m/%Y #[fg=colour10]#[fg=colour233,bg=colour10] Local %H:%M #[fg=colour12]'
