# Light theme: colors only. Layout/format lives in statusline.tmux.
set -gu status-style

# 180 works better for the theme on Ghostty
set -g status-style bg=colour180

set -g @thm_win_cur_fg  black
set -g @thm_win_cur_bg1 colour9
set -g @thm_win_cur_bg2 colour1

set -g @thm_win_fg  colour239
set -g @thm_win_bg1 colour246
set -g @thm_win_bg2 colour252

set -g @thm_date_fg black
set -g @thm_date_bg colour11

set -g @thm_time_fg black
set -g @thm_time_bg colour9
