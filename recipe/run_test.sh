#!/usr/bin/env bash

pyinstaller --help
pyi-archive_viewer --help
pyi-bindepend --help
pyi-makespec --help

pip check

# Remove the test directory which import tkinter which requires X11
rm -rf $SP_DIR/../test

pyinstaller -n hello hello.py

ls -lh dist/hello
dist/hello/./hello