#!/bin/bash

if [[ $# != 1 ]]; then
  echo 'Index bpm metainfo'
  echo 'Usage: > ./start.sh <base_work_folder>'
  exit -1
fi

BASE_WORK_FOLDER=$1

$PREFIX docker run \
  --name=bpmindexer \
  -d \
  --memory=256m \
  --memory-swap=-1 \
  -e BASE_DIR='/opt/app' \
  -v $BASE_WORK_FOLDER:/opt/workdir \
  giorbernal/bpmindexer