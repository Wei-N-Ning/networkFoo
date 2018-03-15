#!/usr/bin/env bash

cd build
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Debug ..
make
make test
cd ..

