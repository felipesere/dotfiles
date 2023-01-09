#! /usr/bin/env bash
#
# {
#   repo: [
#      {
#         numer,
#         title,
#         updatedAt,
#         url
#       },
#       ...
#    ],
#    ...
#}
/opt/homebrew/bin/gh my-prs --json=repository,number,title,updatedAt,url \
    | /opt/homebrew/bin/jq 'group_by(.repository.nameWithOwner) | map({(.[0].repository.nameWithOwner): ([ .[] | del(.repository)])}) | add' \
    | /opt/homebrew/bin/jq -r 'to_entries[] | "* \(.key)", "\(.value[] | "  * [ ] [\(.title)](\(.url))") "'
