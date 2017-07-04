#! /usr/bin/env bash

set -o noclobber
set -o nounset

scrotOrig="/tmp/desktop.png"
scrotBlur="/tmp/desktopBlur.png"

red()   { echo -e "\e[31m$@\e[0m"; }
green() { echo -e "\e[32m$@\e[0m"; }
blue()  { echo -e "\e[34m$@\e[0m"; }

depCheck() {
    if !(scrot --version   &> /dev/null && \
         i3lock --version  &> /dev/null && \
         convert --version &> /dev/null); then
        
        red "Dependancies Not Met!"
        exit 1
    fi
}

main() {
    # Take Screenshot Convert And Display
    scrot -mq 75 $scrotOrig
    convert $scrotOrig -blur 0x7 $scrotBlur
    i3lock -efi $scrotBlur

    # Clean Up
    rm -rf $scrotOrig $scrotBlur
}

depCheck
main
