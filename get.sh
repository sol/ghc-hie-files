#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

repo="sol/ghc-hie-files"
dest="$HOME/.local/state/ghc-hie-files/"

versions=$(cat <<EOF
9.12.2
9.12.1
9.10.3
9.10.2
9.10.1
9.8.4
EOF
)

usage() {
  echo
  echo "Usage:"
  echo
  echo "  bash <(curl -fsSL https://raw.githubusercontent.com/$repo/main/get.sh) [<ghc-version>]"
  echo
  echo "If no version is specified, the version reported by \`ghc --numeric-version\` is used."
  echo
  echo "Available versions:"
  echo
  echo "$versions" | sed 's/^/  /'
  exit 1
}

if [ $# -eq 0 ]; then
  version="$(ghc --numeric-version)"
elif [ $# -eq 1 ]; then
  version="$1"
else
  echo
  echo "Error: too many arguments"
  usage
fi

if ! echo "$versions" | grep -qxF "$version"; then
  echo
  echo "Error: unknown version $version"
  usage
fi

url="https://github.com/$repo/releases/download/$version/ghc-$version.tar.gz"

mkdir -p "$dest"
echo
echo "Downloading HIE files for GHC $version from:"
echo
echo "  $url"
echo
curl --progress-bar -fL "$url" | tar -xz -C "$dest"
echo
echo "Files extracted to:"
echo
echo "  $dest"
