#!/usr/bin/env bash

echo "Running pre-commit hook"
./scripts/run-tests.bash

# $? stores exit value of the last command
if [ $? -ne 0 ]; then
 git reset
 echo "There are 3 possible options to fix when pre-commit hook is triggered"
 exit 1
fi

echo "Branch checking is done : valid"