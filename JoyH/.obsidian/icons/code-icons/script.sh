#!/bin/bash

# Move every file in every child directory to the parent directory
find . -mindepth 2 -type f -exec mv -t . {} +

# Delete all directories in the parent directory
find . -mindepth 1 -maxdepth 1 -type d -exec rm -r {} +