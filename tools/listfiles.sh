#/bin/sh

# This script uses git to list client data files that have been changed between
# two revisions. It excludes deleted files.

git diff --name-only --diff-filter=ACMR $1 -- \
    *.xml \
    music \
    sfx \
    maps \
    automapping \
    icons \
    items \
    minimaps \
    particles \
    sprites \
    tiles
