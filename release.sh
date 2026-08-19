#!/bin/bash
#
# DEST is the destination directory where the repository is saved locally
export VERSION="v0.0.4-rc4"
export BRANCH="release-v0-0-4-rc4"
export SOURCE="../etzba"

mkdir -p "$VERSION"
cp -rv $SOURCE/dist/* $VERSION/

git checkout -b $BRANCH && \
    git add $VERSION/ && \
    git commit -m "Chore(Release): New version $VERSION release" && \
    git push origin HEAD
