#!/bin/bash

if [[ -z ${BASE_DIR} ]]; then
  echo 'Error!. BASE_DIR variable is unset'
  exit -1
fi

if [[ ! -f ${BASE_DIR}/scripts/global.env ]]; then
  echo "Error!. ${BASE_DIR}/scripts/global.env does not exist"
  exit -1
fi

. ${BASE_DIR}/scripts/global.env

if [[ $# != 1 ]]; then
  echo 'Remove bpm index metainfo'
  echo 'Usage: > ./bpmDetectionClean.sh <folder>'
  exit -1
fi

FOLDER="$1"

find "$FOLDER/" -type f -iname "$RESULTS" -exec rm -f {} \;
