# Dark theme: colors only. Layout/format lives in statusline.tmux.
set -gu status-style

# 👇 this controls the actual background of the status bar
set -g status-style bg=colour236

set -g @thm_win_cur_fg  colour16
set -g @thm_win_cur_bg1 colour8
set -g @thm_win_cur_bg2 colour12

set -g @thm_win_fg  colour233
set -g @thm_win_bg1 colour238
set -g @thm_win_bg2 colour240

set -g @thm_date_fg colour233
set -g @thm_date_bg colour4

set -g @thm_time_fg colour233
set -g @thm_time_bg colour10
