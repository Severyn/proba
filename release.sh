#!/bin/bash

# get script dir
if [ -L $0 ]; then
    BASEDIR=$(dirname $(readlink $0))
else
    BASEDIR="$(cd "$(dirname "$0")" && pwd -P)"
fi

DIR="$BASEDIR/../dist"

# If an argument was passed
if [ "$1" != "" ]; then
    if [ -d $1 ]; then
      DIR=$1
    else
      echo "ERROR: $1 not is a valid folder"
      exit 1
    fi
fi

cd $DIR

BRANCH="release"

# If an second argument was passed
if [ "$2" != "" ]; then
    REPO=$2
fi

if [ "$3" != "" ]; then
    BRANCH=$3
fi

if [ "$REPO" == "" ]; then
  REPO="$(cd .. && git remote get-url origin && cd $DIR)"
fi

echo ""
echo "DIR: $DIR"
echo "REPO: $REPO master:$BRANCH"
echo ""

# release script
MESSAGE="release: $(date) // $(whoami)@$(hostname)"

rm -rf .git

git init
git add -A
git commit -m "$MESSAGE"
git push -f $REPO master:$BRANCH

rm -rf .git
