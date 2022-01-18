#!/usr/bin/env bash

if [[ "${target_platform}" == "linux-aarch64" ]]; then
    export CFLAGS="$CFLAGS -mtune=generic"
fi

declare -a _RUN_DEBUG=()
# If you need to figure out what's going on here:
# _RUN_DEBUG+=('-d')
# all,imports,bootloader,noarchive
# _RUN_DEBUG+=('-all')

declare -a _BUILD_DEBUG=()
_BUILD_DEBUG+=('--log-level')
_BUILD_DEBUG+=('INFO')

declare -a _PROJECTS=()
_PROJECTS+=('hello')
_PROJECTS+=('multiprocessing_test')

for _PROJECT in "${_PROJECTS[@]}"; do
  echo "Checking we can build ${_PROJECT}"
  [[ -d "${HOME}/Library/Application Support/pyinstaller" ]] && rm -rf "${HOME}/Library/Application Support/pyinstaller"
  _DISTPATH=${PWD}/dist.${PYVER}.${_PROJECT}
  _WORKPATH=${PWD}/work.${PYVER}.${_PROJECT}
  [[ -d ${_DISTPATH} ]] && rm -rf ${_DISTPATH}
  [[ -d ${_WORKPATH} ]] && rm -rf ${_WORKPATH}
  pyinstaller "${_RUN_DEBUG[@]}" "${_BUILD_DEBUG[@]}" --distpath=${_DISTPATH} --workpath=${_WORKPATH} --noconfirm -n ${_PROJECT} ${_PROJECT}.py
  ls -lh ${_DISTPATH}/${_PROJECT}
  ${_DISTPATH}/${_PROJECT}/./${_PROJECT}
done
