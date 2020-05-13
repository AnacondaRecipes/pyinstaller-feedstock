#!/usr/bin/env bash

declare -a _RUN_DEBUG=()
# If you need to figure out what's going on here:
# _RUN_DEBUG+=('-d')
# all,imports,bootloader,noarchive
# _RUN_DEBUG+=('-all')

declare -a _BUILD_DEBUG=()
_BUILD_DEBUG+=('--log-level')
_BUILD_DEBUG+=('INFO')

[[ -d dist ]] && rm -rf dist
[[ -d "${HOME}/Library/Application Support/pyinstaller" ]] && rm -rf "${HOME}/Library/Application Support/pyinstaller"
pyinstaller "${_RUN_DEBUG[@]}" "${_BUILD_DEBUG[@]}" --noconfirm -n hello hello.py
ls -lh dist/hello
dist/hello/./hello

# _MP_OUT_EXPECT=$(echo -e "main 1\nmain 2\nSendeventProcess 1\SendeventProcess 2\n")
[[ -d dist ]] && rm -rf dist
[[ -d "${HOME}/Library/Application Support/pyinstaller" ]] && rm -rf "${HOME}/Library/Application Support/pyinstaller"
pyinstaller "${_RUN_DEBUG[@]}" "${_BUILD_DEBUG[@]}" --noconfirm -n multiprocessing_test  \
  --hiddenimport=multiprocessing.set_start_method  \
  multiprocessing_test.py
ls -lh dist/multiprocessing_test

# This was intended to debug a bug on macOS Python, but it doesn't work there!
# (dist/multiprocessing_test/./multiprocessing_test) & pid=$!
# in the background, sleep for 10 secs then kill that process
# (sleep 10 && kill -9 $pid) & waiter=$!
# wait on our worker process and return the exitcode
# exitcode=$(wait $pid && echo $?)
# kill the waiter subshell, if it still runs
# kill -9 $waiter 2>/dev/null
# 0 if we killed the waiter, cause that means the process finished before the waiter
# finished_gracefully=$?
# if [[ ${finished_gracefully} != 0 ]]; then
#   echo "ERROR :: multiprocessing test took longer than 10 seconds. It is broken. Is this:"
#   echo "ERROR :: https://bugs.python.org/issue40106"
#   exit 1
# fi

_MP_OUT_TEST=$(dist/multiprocessing_test/./multiprocessing_test)
echo -e "INFO :: expected something like:\n${_MP_OUT_EXPECT}"
echo -e "INFO :: got:\n${_MP_OUT_TEST}"
