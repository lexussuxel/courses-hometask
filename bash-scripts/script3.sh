#!/bin/bash

function clone_repo(){
  local repo ;

  if [ -z "$1" ]; then
    echo "You should add repository link"
    while read repo_input && [ -n "$repo_input" ]; do
      if [ -z "$repo_input" ]; then
        echo "You should add repository link"
      else
        repo=$repo_input
        break
      fi
    done
  else
    repo=$1
  fi

  git clone $repo
  repo_dir=$(echo $repo | cut -d "/" -f2 | cut -d "." -f1)
  echo "$repo_dir"
}

function update_repo(){
  $desc = git describe --tags
  if [ grep -q "-" $desc ]; then 
    local new_tag = echo $desc | cut -d "-" | awk '{print $1.$2.$3+1}'
    echo $new_tag
  else 
   echo "No changes"
  fi
}

cd "$(clone_repo $1)"
update_repo
