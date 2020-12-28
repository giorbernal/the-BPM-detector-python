#!/bin/bash

if [[ $# != 1 ]]; then
  echo 'delete bpm metainfo'
  echo 'Usage: > ./clean.sh <folder>'
  exit -1
fi

$PREFIX docker exec bpmindexer /opt/app/scripts/bpmDetectionClean.sh "/opt/workdir/$1"
