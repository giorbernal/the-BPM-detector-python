#!/bin/bash

. ${BASE_DIR}/scripts/utils.sh

FILE=$1

echo "----------------------------------------------------------------------------------------------------"
echo "processing $FILE ..."
echo "----------------------------------------------------------------------------------------------------"

DURATION=$(ffprobe -i "$FILE" -show_entries format=duration -v quiet -of csv="p=0" | awk '{print int($1)}')

RES=""

for i in $((DURATION/6)) $((2*DURATION/6)) $((3*DURATION/6)) $((4*DURATION/6)) $((5*DURATION/6)); do
  ffmpeg -ss ${i} -t ${TIME_LENGTH} -i "$FILE" -acodec pcm_u8 -ar 22050 $TEMP
  RESI=$(python ${PYTHON_APP_PATH}/bpm_detection.py --filename $TEMP --window 3,6,7,8,9,10,12 --plotmode False)
  checkAndRemoveFile $TEMP
  RES="$RES|$RESI"
done

RES_CLEAN=${RES:1}
BPM_REDUCED=$(python ${PYTHON_APP_PATH}/utils.py --reduceBpm "${RES_CLEAN}")

echo "$FILE $IND ${BPM_REDUCED} bpm" >> "$FOLDER/$RESULTS"
echo "----------------------------------------------------------------------------------------------------"
echo "$FILE processed!"
echo "----------------------------------------------------------------------------------------------------"
echo ""
