#!/usr/bin/env bash

#----------------------------#
#-| Test Internet settings |-#
#----------------------------#

set -o nounset
set -o noclobber

varGateway='192.168.0.254'
varDNS='192.168.0.1'
varPingAddress='8.8.8.8'
varNameToResolve='www.google.ca'

while :; do
    clear

    if (timeout 2 ping -c 1 $varGateway &> /dev/null ); then
        echo "Gateway is UP!"
    else
        echo "Gateway is Down"
    fi

    if (timeout 2 ping -c 1 $varDNS &> /dev/null ); then
        echo "DNS Server is UP!"
    else
        echo "DNS Server is Down!"
    fi

    if (timeout 2 ping -c 1 $varPingAddress &> /dev/null ); then
        echo "Ping to '$varPingAddress' SUCCESSFUL!"
    else
        echo "Ping to '$varPingAddress' FAILED!"
    fi

    if (timeout 2 nslookup $varNameToResolve $varDNS &> /dev/null ); then
        echo "Name Resolution is WORKING!"
    else
        echo "Name Resolution is NOT WOKRING!"
    fi

    sleep 3
done

exit
