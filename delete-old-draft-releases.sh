#!/usr/bin/env bash
set -euo pipefail

github_api_url=$1
github_repo=$2
github_token=$3
release_id=$4

repo_api="$github_api_url/repos/$github_repo"
auth_header="authorization: Bearer $github_token"

function sort_age_desc { jq 'sort_by(.id) | reverse'; }

# Prune fields and squash each release to one line, for streaming onwards.
function split_releases { jq -c '.[] | {id, name, draft}'; }

function delete_old_drafts {
  start_deleting=false
  while read -r release; do
    id=$(jq '.id' <<< "$release")
    name=$(jq '.name' <<< "$release")
    draft=$(jq '.draft' <<< "$release")

    if [ "$start_deleting" = true ]; then
      if [ "$draft" = true ]; then
        echo "Deleting draft release $id ($name)"
        curl -# -XDELETE -H "$auth_header" "$repo_api/releases/$id"
      fi
      continue
    fi

    if [ "$id" = "$release_id" ]; then
      start_deleting=true
      echo "Found release $id ($name)"
    fi
  done
}

curl -# -H "$auth_header" "$repo_api/releases?per_page=100" \
  | sort_age_desc | split_releases | delete_old_drafts
