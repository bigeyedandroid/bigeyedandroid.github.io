#!/bin/bash

ROOT_DIR=$(git rev-parse --show-toplevel)
cd $ROOT_DIR/source
hugo -t cactus -d $ROOT_DIR