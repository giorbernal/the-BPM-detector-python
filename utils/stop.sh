#!/bin/bash

$PREFIX docker stop	bpmindexer
$PREFIX docker rm bpmindexer $@
