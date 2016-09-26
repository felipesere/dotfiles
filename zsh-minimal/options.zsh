setopt extendedglob          # treat #, ~, and  ^ as part of pattern for filename generation
setopt autocd                # don't require a cd to change directory
setopt auto_menu             # show completion menu on succesive tab press
unsetopt menu_complete       # do not autoselect the first completion entry
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt append_history        # multiple shells output to the same history file
setopt hist_find_no_dups     # when searching through history, don't show stuff that has already been cycled through
setopt hist_verify           # expand stuff from history, don't run it. (double confirmation)
setopt prompt_subst          # allow expansion in sub-prompts
unsetopt correct             # diable auto-correct for commands
unsetopt correctAll          # disable auto-correct for arguments
unsetopt flowcontrol
setopt always_to_end
setopt nonomatch                # try to avoid the 'zsh: no matches found...'
setopt notify                # report the status of backgrounds jobs immediately
setopt hash_list_all         # whenever a command completion is attempted, make sure the entire command path is hashed first.
setopt completeinword # not just at the end
setopt noshwordsplit # use zsh style word splitting
setopt interactivecomments # allow use of comments in interactive code
