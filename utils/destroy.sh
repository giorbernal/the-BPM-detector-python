#!/bin/bash

IMAGE_ID=$($PREFIX docker images | grep giorbernal/bpmindexer | awk '{print $3}')
$PREFIX docker rmi ${IMAGE_ID}
