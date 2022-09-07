#!/bin/bash

checkout_and_merge() {
  git checkout $1
  if [ $? -ne 0 ]; then
    exit
  fi
  git merge $2
}

merge_ladder() {
  local branch_pattern_name=$1
  local branches_num=$2
  local target_branch=$3
  local word_branch_separator=$4-
  local branch_to_merge=$branch_pattern_name-$target_branch

  for num in $(seq 1 $branches_num); do
    local previous_branch=$(expr $num - 1)
    if [ $previous_branch -ne 0 ]; then
      branch_to_merge=$branch_pattern_name-$word_branch_separator$previous_branch
    fi

    checkout_and_merge $branch_pattern_name-$word_branch_separator$num $branch_to_merge 2>error-checkout-merge.log
  done
}

merge_ladder $1 $2 $3 $4 2>errors.log
