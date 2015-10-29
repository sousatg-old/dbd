#!/bin/sh

hardwareList=("Wi-Fi" "Ethernet")
i=1

echo "Select the interface you want to apply DNS"

for N in "${hardwareList[@]}"
do
        echo "$i - $N"
        i=$((i+1))
done

read interface

echo "${hardwareList[(interface-1)]}"

clear

sudo networksetup -setdnsservers ${hardwareList[(interface-1)]}  8.8.8.8 8.8.4.4

echo "DNS changed...\n\n\nEnjoy your freedom mate! :)"
