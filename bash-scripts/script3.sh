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
  local desc=$(git describe --tags)
  if echo "$desc" | grep -q "-"; then 
    local new_tag=$(echo "$desc" | cut -d "-" -f1 | awk -F. '{print $1"."$2"."$3+1}')
    git tag -a $new_tag -m "Updating version to $new_tag"
    git push origin $new_tag
  else 
    echo "No changes"
  fi
}

clonned_repo_dir=$(clone_repo $1)
cd "$clonned_repo_dir"
pwd
update_repo 
cd ..
rm -rf "$clonned_repo_dir"