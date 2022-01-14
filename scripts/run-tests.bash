#!/usr/bin/env bash

echo "Running tests"
echo "............................"

# This should be run, in order to balance the package.json and package-lock.json
npm install


# cheking which modules have high and critical.
OUT=$(npm audit --json --registry https://registry.npmjs.org/)

HIGH=$(echo "$OUT" | grep high | tail -1 | awk '{print $2}' | tr -d ,)

CRITICAL=$(echo "$OUT" | grep \"critical\": | tail -1 | awk '{print $2}')

if [[ 0 -lt $HIGH ]]; then
  printf "\t\033[41mAlert! High vulnerable : $HIGH\033[0m"
  echo ""
	exit 1
else
  printf "\t\033[32mNo High vulnerable\033[0m"
	echo ""
fi

if [[ 0 -lt $CRITICAL ]]; then
  printf "\t\033[41mAlert! Critical vulnerable : $CRITICAL\033[0m"
	echo ""
	exit 1
else
  printf "\t\033[32mNo Critical vulnerable\033[0m"
	echo ""
fi

#Git hooks to enforce branch naming policy
#Branch names in this project must adhere to this contract: (master, development, feature, stage, release, hotfix, bugfix) and use only these latters (A-Za-z0-9._-) create branch name,or else Your commit will be rejected
echo "Git hooks to enforce branch naming policy checker is running"

local_branch="$(git rev-parse --abbrev-ref HEAD)"
main_branches_regex="^(development|stage|master|main)$"
valid_branch_regex="^(bugfix|release|hotfix|feature)\/[A-Za-z0-9._-]+$"

condition=false
if [[ $local_branch =~ $main_branches_regex ]]; then 
    printf "\t\033[32mBranch checking is done : valid\033[0m"
	  echo ""
    condition=true
fi

if [[ $condition == false ]]; then
    if [[ ! $local_branch =~ $valid_branch_regex ]]; then 
      printf "\t\033[41mBranch names in this project must adhere to this contract: (master, development, feature, stage, release, hotfix, bugfix) and use only these latters (A-Za-z0-9._-) create branch name,or else Your commit will be rejected.try again\033[0m"
      echo ""
      exit 1 
    fi 
fi
