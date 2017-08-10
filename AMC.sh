#! /usr/bin/env bash

WAIT_TIME="86400"
AMC_OUTPUT="$HOME/Media"
AMC_INPUT="$HOME/Torrents/Completed"
AMC_ACTION="move"
AMC_LABEL=""

log() { echo -e "$(date +"%F %T"): \e[34m$@\e[0m" | tee -a "$LOG_FILE"; }

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
        --def ut_label="$AMC_LABEL"         \
        --def excludeList-AMCExclude.txt    

    STATUS="$?"
    [[ "$STATUS" = 0 ]] && log "AMC Completed Successfully..." || log "AMC Failure..."
    [[ "$STATUS" = 0 ]] && log "Continuing..." || exit 1

    log "Sleeping Until $(date +"%F %T" --date "$WAIT_TIME seconds")..."
sleep "$WAIT_TIME"

done




