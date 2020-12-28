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
. ${BASE_DIR}/scripts/utils.sh

if [[ $# != 1 ]]; then
  echo 'index bpm metainfo'
  echo 'Usage: > ./bpmDetectionCalculate.sh <folder>'
  exit -1
fi

export FOLDER=$1

checkAndRemoveFile "$FOLDER/$RESULTS"
touch "$FOLDER/$RESULTS"

find "$FOLDER" -type f -iname "*.wav" -exec sh -c "${BASE_DIR}/scripts/processFile.sh \"{}\"" \;
find "$FOLDER" -type f -iname "*.mp3" -exec sh -c "${BASE_DIR}/scripts/processFile.sh \"{}\"" \;
