#!/bin/bash

EMMAKE=emmake
EMCC=emcc
NODE=node

if [ ! -d "../../minisat" ]; then
    echo "Please clone the meteor/minisat repo in the same directory as the meteor/minisat-emscripten repo and check out the 'emscripten' branch."
    exit 1
fi

echo "Building"

pushd ../../minisat
rm -rf build/release/* # clean minisat's build dir; when is it necessary?
$EMMAKE make r
cd build/release/bin
ln -s minisat minisat.bc
# flags reference: http://kripken.github.io/emscripten-site/docs/tools_reference/emcc.html
$EMCC -O3 --memory-init-file 0 --bind -s EXPORTED_FUNCTIONS='["_solve_string"]' -s TOTAL_MEMORY=67108864 minisat.bc -o minisat.js
popd

mkdir -p build
cp ../../minisat/build/release/bin/minisat.js build

echo "Testing"
$NODE test.js
