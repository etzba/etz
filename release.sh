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

curl -LO https://raw.githubusercontent.com/etzba/etz/master/v0.0.4-rc4/etzba_linux_amd64_v1/etz
curl -LO https://raw.githubusercontent.com/etzba/etz/master/v0.0.4-rc4/etzba_linux_amd64_v1/etz.sig
curl -LO https://raw.githubusercontent.com/etzba/etz/master/pubkey.asc
