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

if [[ $# != 3 ]]; then
  echo 'Search songs by bpm'
  echo 'Usage: > ./bpmDetectionSearch.sh <folder> <bpm> <margin>'
  exit -1
fi

FOLDER="$1"
BPM=$2
MARGIN=$3

find "$FOLDER/" -type f -iname "$RESULTS" | xargs grep "\\$IND $BPM.0 "
for (( i=1; i<=$MARGIN; i++ )); do
  find "$FOLDER/" -type f -iname "$RESULTS" | xargs grep "\\$IND $((BPM+$i)).0 "
  find "$FOLDER/" -type f -iname "$RESULTS" | xargs grep "\\$IND $((BPM-$i)).0 "
done
