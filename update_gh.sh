#!/bin/bash

set -e

GH_VERSION=$1 # v_.__.__

if [[ -z ${GH_VERSION} ]]; then
  # TODO Remove 'jq' dependency
  #      Ref: https://bit.ly/2XGRD0d
  if [[ -z $(which jq) ]]; then
    echo "ERROR! 'jq' is required to get latest version"
    exit 1
  fi

  GH_VERSION=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | jq -r '.tag_name')
  # On failure, this might be 'null'
  # TODO Manage such case
fi

if [[ -z ${GH_VERSION} ]]; then
  echo "ERROR! 'gh' version is not provided"
  exit 1
fi

echo "Try to download and install gh ${GH_VERSION}"

# TODO Check system arch
GH_DEB_FILENAME=gh_${GH_VERSION:1}_linux_amd64.deb
GH_RELEASE_URL=https://github.com/cli/cli/releases/download/${GH_VERSION}/${GH_DEB_FILENAME}

echo "(${GH_RELEASE_URL})"

cd $(mktemp -d)
# TODO Check whether URL exists
wget -q ${GH_RELEASE_URL}

sudo dpkg -i ${GH_DEB_FILENAME}
