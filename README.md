Intro
=====

This script makes it possible to delete old branches from your git repository.
You can select based on year, year and month or even day.

For example to list all branches that were active up to year 2015:

    bash list_branches_to_delete.sh ^2015

Why?
====

I wrote this script, because some git repository providers still do not have 'batch delete branches' option in the GUI.


Usage
=====

0. Put `list_branches_to_delete.sh` in your `$PATH`

1. Prepare `GIT_BRANCH_DELETE_keep_branches.txt` file - this file should contain all the branches you would like to keep, even if they are old.
Usually those are branches containing old merge requests.

2. Run `list_branches_to_delete.sh`

3. Review `GIT_BRANCH_DELETE_branches_to_delete.txt` file

4. Execute:

    for branch in `cat GIT_BRANCH_DELETE_branches_to_delete.txt |xargs -0`; do echo "About to delete $branch"; git push origin :$branch; done

NOTE: `xargs -0` is required, because some branches can contain "'" character, e.g.: `this_branch_couldn't_be_removed`

5. Enjoy cleaned up repository!
