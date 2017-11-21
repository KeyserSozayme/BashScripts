#! /usr/bin/env bash

WAIT_TIME="172800"
AMC_OUTPUT="/Media"
AMC_INPUT="/home/keith/Torrents/Completed"
AMC_ACTION="move"
AMC_LABEL=""

log() { echo -e "\e[34m$@\e[0m"; }

while :; do

    LOG_FILE="/tmp/AMC-$(date +"%F %T").log"
    touch "$LOG_FILE"

    log "Starting Filebot AMC..."
    
    filebot -script fn:amc                  \
        --output "$AMC_OUTPUT"              \
        -non-strict "$AMC_INPUT"            \
        --action "$AMC_ACTION"              \
        --def subtitles=en                  \
        --def artwork=y                     \
        --def clean=y                       \
        --def unsorted=y                    \
        --def extra=y                       \
        --def minLengthMS=10                \
        --def minFileSize=10                \
        --def extra=y                       \
        --def ut_label="$AMC_LABEL"         

    STATUS="$?"
    [[ "$STATUS" = 0 ]] && log "AMC Completed Successfully..." || log "AMC Failure..."
    [[ "$STATUS" = 0 ]] && log "Continuing..." || exit 1

    log "Sleeping Until $(date +"%F %T" --date "$WAIT_TIME seconds")..."
sleep "$WAIT_TIME"

done




