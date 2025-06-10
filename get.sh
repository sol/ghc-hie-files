#!/usr/bin/env bash
set -o nounset
set -o errexit
set -o pipefail

repo="sol/ghc-hie-files"
dest="$HOME/.local/state/ghc-hie-files/"

versions="9.12.2 9.12.1 9.10.2 9.10.1 9.8.4 9.8.3 9.8.2 9.8.1"

usage() {
  echo
  echo "Usage:"
  echo
  echo "  get.sh <ghc-version>"
  echo
  echo "Available versions:"
  echo
  printf '  %s\n' $versions
  exit 1
}

if [ $# -ne 1 ]; then
  echo
  echo "Error: missing version"
  usage
fi

version="$1"
if ! grep -Fxq "$version" <<< "$(printf '%s\n' $versions)"; then
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
