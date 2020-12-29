#!/bin/bash
# Pavel Hryshunin, grupa 1
 
#A script which blacklists an IP or unblocks an IP
#Parameters:
#
#-i <IP address>
#-a <list|delist>

basename=`basename $0`
NO_ARGS=0

DIR=$(dirname $(readlink -e "$0"))

cd $DIR

chmod +x myfuncs
source myfuncs


help()
{
    echo -e "\e[31m This script helps to block IP addresses. These IPs you can block and unblock.
    You must have root rights / if necessary, add “sudo” to the beginning of the line. \e[0m"
    echo "Usage: (sudo) $basename [-i <IP-addres>] [-a <list|delist>]"      
    echo "";
    echo -e "-i | --ip-address (XXX.XXX.XXX.XXX) which is to be blocked or unblocked"
    echo -e "-a | --action \e[4mlist / delist\e[0m (block / unblock)."
    echo "-c | --count just count IPs that were already blockeds (which written in ip route table)"
    echo "-h | --help Prints this help message"
    exit 1
}
   
   
Check_if_root ()       # Проверка прав пользователя.
{                      
  if [ $UID -ne 0 ]       #UID sudo = 0
  then
    echo -e "\e[31mERROR: This script must be run with root privileges!\e[0m"
    exit 1
  fi
}   


ping_ip()
{
   if ping -c 1 $IP &> /dev/null;
then
	echo -e "ping $IP - OK"
else
	echo -e "ERROR: IP-addres: $IP is not found in the system!"
	exit 1
fi
}
   
usage()
{
    echo "Usage: (sudo) $basename [-i <IP-addres>] [-a <list|delist>]" 1>&2; exit 1;      
}
 
block_ip()
{

    Check_if_root             # Проверка прав пользователя.
    
    if [ -z "$1" ]           # Нет аргументов
    then
        exit 1
    fi
   
    if valid_ip $1;
    then
    stat="good"
    else
    stat="bad"
    fi
    if [[ $stat = "bad" ]]
    then
    echo "This is not a valid IP address. Exiting..."
    exit 1
    fi
    
    ping_ip
    
#     if ping -c 1 $1 &> /dev/null
#     then 
#        echo "IP $IP has been successfully blocked"
    
    
     str=`ip route | grep $1 | tr -d "blackhole"`
     strlength=`echo -n $str | wc -c`
     
    if [ $str = "$1" 2>/dev/null ]
    then
    echo "This IP has been already blocked. No need to block again. Try to unblock instead"
    exit 1
    fi
    ip route add blackhole $1
 
    str=`ip route | grep "$1" | tr -d "blackhole"`
    strlength=`echo -n $str | wc -c`
    
    if [ $strlength > 0 ] && [ $str = "$1" ];
    then
    echo "IP $IP has been successfully blocked"
    exit 0
    else
    echo "There was a problem while blocking IP $IP"
    fi
}
  

  
unblock_ip()
{

    Check_if_root         # Проверка прав пользователя.
    if [ -z "$1" ]
    then
    exit 1
    fi
   
    str=`ip route | grep "$1"`
    strlength=`echo -n $str | wc -c`
   
    if [ $strlength = 0 ]
    then
    echo "IP $1 is not in blackhole. Nothing to delist"
    exit 0
    else
    ip route del blackhole "$1"
    str=`ip route | grep "$1"`
    strlength=`echo -n $str | wc -c`
    if [[ $strlength = "0" ]]
    then
        echo "IP $1 has been successfully delisted from the blackhole"
        exit 0
    else
        echo "There was an error while delisting IP $1"
    fi
    fi
   
}
  
 
count()
{
    echo "IP blocked:" `ip route | grep blackhole | wc -l`;    #write number of blackhole lines in ip route table.
    return 0
}
 
if [ $# = $NO_ARGS ]
then
    usage
fi 
 
  
while getopts "i:a:ch" arg; do
    case $arg in
    i)  IP=${OPTARG}
        ;;
        
    c) count
        exit 0
        ;;
        
    a)  ACTION=${OPTARG}
        ;;  
       
       
    h)  help
        ;;
       
    *)  usage
        ;;
    esac
done
 
 
 
if [[ $ACTION != "list" && $ACTION != "delist" ]]
then
    usage
fi
 
case $ACTION in
    list)
        block_ip $IP
    exit 0
    ;;
   
    delist) 
        unblock_ip $IP
    exit 0
    ;;
   
   count)  count
    ;;   
    
    *)  usage
    exit 1
esac

