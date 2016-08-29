setopt extendedglob          # treat #, ~, and  ^ as part of pattern for filename generation
setopt autocd                # don't require a cd to change directory
setopt auto_menu             # show completion menu on succesive tab press
unsetopt menu_complete       # do not autoselect the first completion entry
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt append_history        # multiple shells output to the same history file
setopt hist_find_no_dups     # when searching through history, don't show stuff that has already been cycled through
setopt hist_verify           # expand stuff from history, don't run it. (double confirmation)
setopt prompt_subst
unsetopt correct             # diable auto-correct for commands
unsetopt correctAll          # disable auto-correct for arguments
unsetopt flowcontrol
setopt complete_in_word
setopt always_to_end
setopt interactive_comments
