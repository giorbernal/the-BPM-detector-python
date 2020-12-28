#!/bin/bash

if [[ $# != 3 ]]; then
  echo 'Search songs by bpm'
  echo 'Usage: > ./search.sh <folder> <bpm> <margin>'
  exit -1
fi

$PREFIX docker exec bpmindexer /opt/app/scripts/bpmDetectionSearch.sh "/opt/workdir/$1" $2 $3
