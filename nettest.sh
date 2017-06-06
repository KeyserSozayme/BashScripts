#!/usr/bin/env bash

#----------------------------#
#-| Test Internet settings |-#
#----------------------------#

set -o nounset
set -o noclobber

## VARIABLES

varGateway='192.168.0.254'
varDNS='192.168.0.1'
varPingAddress='8.8.8.8'
varNameToResolve='www.google.ca'

## FUNCTIONS

red()   { echo -e "\e[31m$@\e[0m"; }
green() { echo -e "\e[32m$@\e[0m"; }

usage() {
# Can't indent the cat block :(
cat << EOF 
Usage: $(basename -s .sh $0)
 [-d <DNS Address>]
 [-g <Gateway Address>]
 [-p <Address For External Ping>]
 [-n <Name To Resolve>]
EOF

}

debug() {
    echo "varGateway        -> '$varGateway'"
    echo "varDNS            -> '$varDNS'"
    echo "varPingAddress    -> '$varPingAddress'"
    echo "varNameToResolve  -> '$varNameToResolve'"
}

## ARGUMENT HANDLING

while getopts :hd:g:p:n:x opt; do
    case $opt in
        h)  usage; exit 0               ;;
        x)  debug                       ;;
        d)  varDNS="$OPTARG"            ;;
        g)  varGateway="$OPTARG"        ;;
        p)  varPingAddress="$OPTARG"    ;;
        n)  varNameToResolve="$OPTARG"  ;;
        *)
            echo "Unrecognized Option '-$OPTARG'"
            usage
            exit 1
            ;;
    esac
done

## MAIN BIT

while :; do
    clear

    if (timeout 2 ping -c 1 $varGateway &> /dev/null ); then
        green "Gateway is UP!"
    else
        red "Gateway is Down"
    fi

    if (timeout 2 ping -c 1 $varDNS &> /dev/null ); then
        green "DNS Server is UP!"
    else
        red "DNS Server is Down!"
    fi

    if (timeout 2 ping -c 1 $varPingAddress &> /dev/null ); then
        green "Ping to '$varPingAddress' SUCCESSFUL!"
    else
        red "Ping to '$varPingAddress' FAILED!"
    fi

    if (timeout 2 nslookup $varNameToResolve $varDNS &> /dev/null ); then
        green "Name Resolution is WORKING!"
    else
        red "Name Resolution is NOT WOKRING!"
    fi

    sleep 3
done

exit
