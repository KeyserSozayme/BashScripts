#! /usr/bin/env bash

inputFolder="$HOME/Torrents/Completed"
outputFolder="$HOME/Media"
action="move"

red()   { echo -e "\e[31m$@\e[0m"; }
green() { echo -e "\e[32m$@\e[0m"; }
blue()  { echo -e "\e[34m$@\e[0m"; }

usage() {
cat << EOF
Usage: $(basename -s .sh $0)
 [-i | --input <folder to use as input>]
 [-c | --copy (Copy Files instead of move)]
 [-h | --help (Prints Usage)]
EOF
}

main() {
    green "Begin Media Automation..."
    filebot -script fn:amc          \
        --output $outputFolder      \
        -non-strict $inputFolder    \
        --action $action            \
        --def subtitles=en          \
        --def artwork=y             \
        --def clean=y               \
        --def unsorted=y            \
        --def excludeList AMCExclude.txt
    green "Finished"
    exit 0
}

while [[ $# > 0 ]]; do
    key="$1"
    case $key in
        -i|--input)
            inputFolder="$2"
            shift
            ;;

        -c|--copy)
            action="copy"
            ;;

        -h|--help)
            usage
            exit 0
            ;;

        *)
            echo "Unrecognized Option '$key'"
            usage
            exit 1
            ;;
    esac
    shift
done

main
