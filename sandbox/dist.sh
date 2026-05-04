#!/usr/bin/env bash

set -o nounset
set -o errexit

# dst=$(git describe --tags | sed s/-release//)
dst="ghc-9.12.4"

rm -rf "$dst" "$dst.tar.gz"

mkdir -p "$dst"
find _build/stage1/ -name '*.hie' -print0 | xargs -0 cp --parents -t "$dst"

rm -r "$dst/_build/stage1/utils/"
rm -r "$dst/_build/stage1/ghc/"

mv "$dst/_build/stage1/compiler/build" "$dst/ghc"

find "$dst/_build/" -type d -name build | while read -r dir
do
  pkg=$(basename "$(dirname "$dir")")
  mv "$dir" "$dst/$pkg"
done

rm -r "$dst/_build/"

tar -czvf "$dst.tar.gz" "$dst"

rm -rf "$dst"
