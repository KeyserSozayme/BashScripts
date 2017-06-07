#! /usr/bin/env bash

set -o noclobber
set -o nounset

waitDur=5
attempt="git push"

red()   { echo -e "\e[31m$@\e[0m"; }
green() { echo -e "\e[32m$@\e[0m"; }
blue()  { echo -e "\e[34m$@\e[0m"; }

usage() {
    cat << EOF
Usage: $(basename -s .sh $0)
 [-a <Commamd to Attempt>]
 [-s <Sleep Interval Length>]
EOF
}

debug() {
    echo "waitDur=$waitDur"
    echo "attempt=$attempt"
}

main() {
    while :; do
        clear
    
        blue "Attempting '$attempt' With a sleep of '$waitDur' in between attempts."
        if ($attempt); then
            green "SUCCESS"
            exit 0
        else
            red "FAILURE"
        fi
        sleep $waitDur
    done
}

# Arguments Handling
while [[ $# > 0 ]]; do
    key="$1"
    case $key in
        -a)
            attempt="$2"
            shift
            ;;
        -s)
            waitDur="$2"
            shift
            ;;
        -h)
            usage
            exit 0
            ;;
        -d)
            usage
            debug
            exit 0
            ;;
        *)
            red "Error! '$key' Unrecognized!"
            usage
            exit 1
            ;;
    esac

    shift
done
###

main
