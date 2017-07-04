#! /usr/bin/env bash

set -o noclobber
set -o nounset
#set -o xtrace

#--------------------------#
#-| Status Output for i3 |-#
#--------------------------#

## Variables ##
pauseLen=1
pingAddr=
###############

## Functions ##
red()   { echo -e "\e[31m$@\e[0m"; }
green() { echo -e "\e[32m$@\e[0m"; }
blue()  { echo -e "\e[34m$@\e[0m"; }

usage() {
    cat << EOF
Usage: $(basename -s .sh $0)
 [-p <Length between updates in seconds>]
 [-h Help]
 [-abc Print ABC for Testing]
 [-def Print DEF for Testing]
EOF
}
###############

## Modules ##
doAbc=false
abc() {
    green "abc"
}

doDef=false
def() {
    red "def"
}

doPingTest=false
pingTest() {
    if (ping -c 1 $pingAddr &> /dev/null); then
        green "Ping to '$pingAddr' Success!"
    else
        red "Ping to '$pingAddr' Failure!"
    fi
}
#############

## Main ##
if [[ $# = 0 ]]; then
    red "$(basename -s .sh $0): No Options Passed!"
    exit 1
fi

while [[ $# > 0 ]]; do
    key="$1"
    case $key in

        -abc)   doAbc=true ;;
        -def)   doDef=true ;;

        -ping)  
            doPingTest=true
            pingAddr="$2"
            shift
            ;;
        -p)
            pauseLen="$2"
            shift
            ;;
        -h)
            usage
            exit 0
            ;;
        *)
            red "$(basename -s .sh $0): Unrecognized Option '$key'."
            usage
            exit 1
            ;;
    esac
    shift
done

while :; do
    clear

    $doAbc      && abc
    $doDef      && def
    $doPingTest && pingTest

    sleep $pauseLen
done
##########
