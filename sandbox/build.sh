#!/usr/bin/env bash

set -o nounset
set -o errexit
set -o pipefail

rm -rf ghc-9.12.4
tar -xf ~/.cache/ghc-bench/ghc-9.12.4-src.tar.gz
git diff -R
git checkout ghc-9.12.4/hadrian/src/Settings/Default.hs

cd ghc-9.12.4
./configure
hadrian/build -j # --flavour=quickest
