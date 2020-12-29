#!/bin/bash

# Pavel Hryshunin, grupa 1

help_report="\nProgram return arithmetic result table from 1th arg to 2nd arg. Available operations: "+", "-", "x"="*", "/", "%", "n"="**" \n\nAvailable options:\n  -h [--help]\n  -q [--quiet]\n\n"  
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





if [[ $1 == "+" ]]
    then
        for j in $(seq $2 $3)        #summary table from $1 to $2 
                 do
                 for i in $(seq $2 $3)
                    do
                     echo $[i+j]  
                     done
                 echo -en '\n'               #add zero string
                 done
fi

if [[ $1 == "-" ]]
    then
        if (("$2" < "$3"))
            then
                for j in $(seq $2 $3)        
                    do
                    for i in $(seq $2 $3)
                        do
                        echo $[i-j]  
                        done
                        echo -en '\n'               #add zero string
                    done
        else
            for j in $(seq $3 $2)        
                 do
                 for i in $(seq $3 $2)
                     do
                     echo $[i-j]  
                     done
                     echo -en '\n'               #add zero string
                 done
        fi
fi

if [[ $1 == "x" ]]
    then
        for j in $(seq $2 $3)        #multiplication table from $2 to $3 
                 do
                 for i in $(seq $2 $3)
                    do
                     echo $[i*j]  
                     done
                 echo -en '\n'               #add zero string
                 done
fi

if [[ $1 == "/" ]]
    then
        if (("$2" < "$3"))
            then
                for j in $(seq $2 $3)        
                    do
                    for i in $(seq $2 $3)
                        do
                        echo $[i/j]  
                        done
                        echo -en '\n'               #add zero string
                    done
        else
            for j in $(seq $3 $2)        
                 do
                 for i in $(seq $3 $2)
                     do
                     echo $[i/j]  
                     done
                     echo -en '\n'               #add zero string
                 done
        fi
fi

if [[ $1 == "%" ]]
    then
        if (("$2" < "$3"))
            then
                for j in $(seq $2 $3)        
                    do
                    for i in $(seq $2 $3)
                        do
                        echo $(( $i / $j))  
                        done
                        echo -en '\n'               #add zero string
                    done
        else
            for j in $(seq $3 $2)        
                 do
                 for i in $(seq $3 $2)
                     do
                     echo $(( $i / $j)) 
                     done
                     echo -en '\n'               #add zero string
                 done
        fi
fi

if [[ $1 == "n" ]]
    then
        for j in $(seq $2 $3)        # $2 ** $3 
                 do
                 for i in $(seq $2 $3)
                    do
                    let "z=i**j"
                     echo "z = $z"  
                     done
                 echo -en '\n'               #add zero string
                 done
fi







