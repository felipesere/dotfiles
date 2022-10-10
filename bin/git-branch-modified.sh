#! /bin/bash
#
# Taken from https://github.com/nvim-telescope/telescope.nvim/issues/758

git show-ref --verify --quiet refs/heads/main
if [[ "$?" == "0" ]]; then
    BRANCH="main"
else
    BRANCH="master"
fi

if [[ "$1" == "list" ]]; then
    git diff --name-only --diff-filter=ACMR --relative "$BRANCH"
elif [[ "$1" == "diff" ]]; then
    git diff --diff-filter=ACMR --relative "$BRANCH" "$2"
fi
