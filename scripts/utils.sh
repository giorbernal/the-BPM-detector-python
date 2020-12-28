#!/bin/bash

function checkAndRemoveFile {
  if [[ -f $1 ]]; then
    echo "removing file $1"
    rm -f "$1"
  else
    echo "file $1 can not be removed because it does not exist"
  fi
}