#!/bin/bash
#
# DEST is the destination directory where the repository is saved locally
export VERSION="v0.0.4-rc1"
export BRANCH="release-v0-0-4-rc1"
export SOURCE="../etzba"

git remote set-url origin git@github-etzba:etzba/etz.git
git config user.name "etzba"
git config user.email "support@etzba.com"

mkdir -p "$VERSION"
cp -rv $SOURCE/dist/* $VERSION/
git checkout -b $BRANCH && \
    git add $VERSION/ && \
    git commit -m "Chore(Release): New version $VERSION release" && \
    git push origin HEAD
