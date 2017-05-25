#!/bin/bash

if [ -z "$1" ]
  then
    echo "Please provide regex to filter branches to delete. Input format: '2017-03-22 refs/remotes/origin/branchname'"
    echo "Example: $0 \"(^2016|^2015)\""
    echo "Example: $0 ^2016"
    exit 1
fi

PREFIX="GIT_BRANCH_DELETE_"

git for-each-ref --sort=-committerdate --format='%(committerdate:short) %(refname)' refs/remotes > ${PREFIX}sorted_branches.txt

cat ${PREFIX}sorted_branches.txt |egrep $1 |grep -v master$ | awk '{print $2}'|sed 's/^refs\/remotes\/origin\///g' > ${PREFIX}potential_branches_to_delete.txt

cat << EOF > ${PREFIX}all_keep_branches.txt
master
develop
next
EOF

touch ${PREFIX}keep_branches.txt
cat ${PREFIX}keep_branches.txt >> ${PREFIX}all_keep_branches.txt
grep -v -x -F -f ${PREFIX}all_keep_branches.txt ${PREFIX}potential_branches_to_delete.txt > ${PREFIX}branches_to_delete.txt
