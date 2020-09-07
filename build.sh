#!/bin/bash
set -xe

mkbuild=$(buildah from -v "$TRAVIS_BUILD_DIR":/home/hsk/to_build ghcr.io/sycured/centos-haskell-builder:latest)
buildah run --user root "$mkbuild" bash -c "chown -R hsk /home/hsk/to_build"
buildah run "$mkbuild" -- bash -c "cd /home/hsk/to_build && stack setup && stack build --ghc-options='-fPIC -optl-pthread' --test --copy-bins"