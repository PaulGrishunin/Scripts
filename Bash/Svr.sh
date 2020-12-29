#!/bin/bash
# Piotr Grosiak, Grupa 1

###################	Variables
addr="127.0.0.1"
port=2399

isServer=1
licznik=0

###################	Functions
function loadConfig()
{
	if [ -f ./licznik.rc ]
	then
		while read -r line
		do
			addr=$line
		done < "./licznik.rc"
		port=$line
	fi
	if [ -f ./licznik-$port.rc ]
	then
		while read -r line
		do
			licznik=$line
		done < "./licznik-$port.rc"
	fi
}

function testIP()
{

	if [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
	then
		# 4 numbers with dots
		A="$(cut -d'.' -f1 <<< $1)"
		B="$(cut -d'.' -f2 <<< $1)"
		C="$(cut -d'.' -f3 <<< $1)"
		D="$(cut -d'.' -f4 <<< $1)"
		#Check if numbers are corect
		if [ $A -gt 255 ]
		then
			return 0
		fi
		if [ $B -gt 255 ]
		then
			return 0
		fi
		if [ $C -gt 255 ]
		then
			return 0
		fi
		if [ $D -gt 255 ]
		then
			return 0
		fi
		return 1
	fi
	return 0
}

function saveConfig()
{
	printf "$addr\n$port" > licznik.rc
	echo "$licznik" > licznik-$port.rc
}

function deleteConfig()
{
	rm -f ./licznik*
	exit 0
}

###################	Main script

loadConfig

# Check filename
if [ `basename $0` == "client.sh" ]
then
    isServer=0
fi

# Check input
while getopts ":p:i:csd" o
do
	case ${o} in
	s)
		isServer=1
	;;
	c)
		isServer=0
	;;
	i)
        if testIP ${OPTARG}
        then
            echo "${OPTARG} is not valid IP address"
            exit 1
        else
            addr=${OPTARG}
		fi
	;;
	p)
		port=${OPTARG}
	;;
	d)
		deleteConfig
	;;
	esac
done
saveConfig

# Display info
if [ $isServer -eq 1 ]
then
	echo -n Server
    echo " address: 127.0.0.1:$port"
else
	echo -n Client
    echo " address: $addr:$port"
fi

# Start work
if [ $isServer -eq 1 ]
then
	####################	Server side
    echo Counter status: $licznik
    echo Press Ctrl+C to stop
	while :
    do
        licznik=$(($licznik+1))
        nc -l -p $port <<< $licznik
        echo "$licznik" > licznik-$port.rc
        echo Counter status: $licznik
    done
else
	####################	Client side
	echo -n "Counter status: "
	nc -w1 $addr $port
	echo
fi
