#!/bin/bash

if [[ $# != 1 ]]; then
  echo 'Error in params!'
  echo 'Usage: > ./index.sh <folder>'
  exit -1
fi

$PREFIX docker exec bpmindexer /opt/app/scripts/bpmDetectionCalculate.sh "/opt/workdir/$1"

