#!/bin/bash

# Pavel Hryshunin, grupa 1

addr="127.0.0.1"
port=1223
isServer=1
counter=0
#-------------------

function load_Config()
{
    if [ -f ./counter.rc ]
        then 
            while read line
                do 
                    addr=$line 
                done < "./counter.rc"
                port=$line
    fi
    if [ -f ./counter-$port.rc ]
        then
            while read line
                do
                    counter=$line
                done < "./counter-$port.rc"
    fi
}    

function save_Config()
{
    printf "$addr\n$port" > counter.rc
    echo "$counter" > counter-$port.rc
}

function delete_Config()
{
    rm -f ./counter*
    exit 0
}


function check_IP()
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


load_Config

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
		delete_Config
	;;
	esac
done
save_Config


if [ $isServer -eq 1 ]
    then
    echo -n Server
    echo " address: 127.0.0.1:$port"
else 
    echo -n Client
    echo " address: $addr:$port"
fi


#Run server
if [ $isServer -eq 1 ]
    then
        echo Counter status: $counter
        echo To stop press Ctrl+C
        while :
            do
                counter=$(($counter+1))
                nc -l -p $port <<< $counter
                echo "$counter" > counter-$port.rc
                echo Counter status: $counter
            done
else
    echo -n "Counter status:   To stop press Ctrl+C"
    nc -w1 $addr $port
    echo To stop press Ctrl+C
fi
