# Status-line layout, theme-agnostic.
# Colors come from @thm_* user options, set per-theme in dark.tmux / light.tmux.
# This only needs to be sourced once; switching themes just changes the
# @thm_* values, which are re-resolved live on every status-line render.

setw -g window-status-current-format '#[fg=#{@thm_win_cur_fg},bg=#{@thm_win_cur_bg1}] #I #[bg=#{@thm_win_cur_bg2}] #W #{?window_zoomed_flag,*,}#{?#{>:#{window_panes},1},#{window_panes},} '
setw -g window-status-format         '#[fg=#{@thm_win_fg},bg=#{@thm_win_bg1}] #I #[bg=#{@thm_win_bg2}] #W #{?window_zoomed_flag,*,}#{?#{>:#{window_panes},1},#{window_panes},} '

set -g status-right '#[fg=#{@thm_date_bg}]#[fg=#{@thm_date_fg},bg=#{@thm_date_bg}] %d/%m/%Y #[fg=#{@thm_time_bg}]#[fg=#{@thm_time_fg},bg=#{@thm_time_bg}] %H:%M | UK #(TZ="Europe/London" date +%%H:%%M) '
