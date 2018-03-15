SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_RPROMPT_ORDER=(
  battery
)

SPACESHIP_BATTERY_SHOW=always

SPACESHIP_CHAR_SUFFIX=" "

SPACESHIP_DIR_COLOR="blue"

SPACESHIP_GIT_SYMBOL=" "
SPACESHIP_GIT_STATUS_STASHED=""
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_GIT_BRANCH_COLOR="yellow"

SPACESHIP_JOBS_SYMBOL="‼️"
SPACESHIP_JOBS_SUFFIX="  "
