#!/bin/bash

# Pavel Hryshunin, grupa 1

help_report="\nProgram return multiplication table from 1th arg to 2nd arg. If no args - return standart multiplication table from 1 to 9\n\nAvailable options:\n  -h [--help]\n  -q [--quiet]\n\n"  
is_quiet=false
is_help=false
is_invalid_cmd=false

#block of options
for var in "$@"
do
    if [[ $var == "-h" ]] || [[ $var == "--help" ]]; then is_help=true; fi
	if [[ $var == "-q" ]] || [[ $var == "-quiet" ]]; then is_quiet=true; fi
#	if [ ${var:0:1} == "-" ]; then is_invalid_cmd=true; fi
done

if $is_help; then echo -e "${help_report}"; exit 0; fi	
if $is_quiet; then exit 0; fi
#if $is_valid_cmd; then echo -e "\n$var: invalid command\n"; echo -e "${help_report}"; exit 1; fi



# if zero args

if [ $# -eq 0 ]                        # standart multiplication table 
    then
    echo $[{1..9}*{1..9}] | xargs -n9 | column -t
else
    if [[ $var = *[[:digit:]]* ]]     # Check for args are integers
        then
#        
        if [ $# -eq 1 ]                # if 1 arg
            then
            for j in $(seq 1 $1)       #multiplication table from 1 to $1  
                do
                for i in $(seq 1 $1)
                    do
                    echo $[i*j]
                    done
                echo -en '\n'               #add zero string
                done
        else
            if (("$1" < "$2"))
            then
            for j in $(seq $1 $2)        #multiplication table from $1 to $2 
                do
                for i in $(seq $1 $2)
                    do
                    echo $[i*j]
                    done
                echo -en '\n'               #add zero string
                done
             else
             for j in $(seq $2 $1)        #multiplication table from $2 to $1 
                do
                for i in $(seq $2 $1)
                    do
                    echo $[i*j]
                    done
                echo -en '\n'               #add zero string
                done
             fi
        fi
     
    else
    echo "One of arguments is not numeric"
    fi
fi








