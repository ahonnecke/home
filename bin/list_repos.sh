#!/bin/bash
for REPO in ~/src/*; do
    cd $REPO && git remote -v | grep origin && cd ..
done
