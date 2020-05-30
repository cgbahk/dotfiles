#!/bin/bash

# TODO Check argc
GH_VERSION=$1
# TODO Check system arch
# TODO Get latest version automatically
#      Ref: https://bit.ly/2XGRD0d
GH_DEB_FILENAME=gh_${GH_VERSION}_linux_amd64.deb
GH_RELEASE_URL=https://github.com/cli/cli/releases/download/v${GH_VERSION}/${GH_DEB_FILENAME}

cd $(mktemp -d)
# TODO Check whether URL exists
wget ${GH_RELEASE_URL}

sudo dpkg -i ${GH_DEB_FILENAME}
