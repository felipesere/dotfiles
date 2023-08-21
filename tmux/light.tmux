# Reset the styles that we modify in this file
set -gu status-style
set -gu window-status-current-format
set -gu window-status-format

# 👇 this controls the actual background of the status bar
set -g status-style bg=colour8

setw -g window-status-current-format  '#[fg=black,bg=colour9] #I #[bg=colour1] #W '
setw -g window-status-format          '#[fg=colour239,bg=colour246 ] #I #[bg=colour252] #W '

set -g status-right '#[fg=colour11]#[bg=colour11,fg=black] %d/%m/%Y #[fg=colour9]#[bg=colour9,fg=black] Local %H:%M | Eirik: #(TZ="CEST" date +%%H:%%M)'
