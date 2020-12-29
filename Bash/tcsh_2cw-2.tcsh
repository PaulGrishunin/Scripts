#!/bin/tcsh

# Pavel Hryshunin, grupa 1

set help_report="\nProgram return multiplication table from 1th arg to 2nd arg. If no args - return standart multiplication table from 1 to 9\n\nAvailable options:\n  -h [--help]\n  -q [--quiet]\n\n"   

# block of options
foreach var ( $argv )
	if ( "$var" == "-h" || "$var" == "--help" ) then
		echo "${help_report}"
		exit 0
	endif
end

foreach var ( $argv )
	if ( "$var" == "-q" || "$var" == "-quiet" ) then
		exit 0
	endif
end

foreach var ( $argv )
	if ( "$var" =~ '-*') then
		echo "${var}: invalid command"
		echo "$help_report"
		exit 1
	endif
end



if ( $#argv == 0 ) then                     
    echo "$[{1..9}*{1..9}]" | xargs -n9 | column -t
else
    if ( $var == "*[[:digit:]]*" ) then    # Check for args are integer
        if ( $#argv == "1" ) then              # if 1 arg
            foreach j in $(seq 1 $1)       # multiplication table from 1 to $1 
                foreach i in $(seq 1 $1)
                    echo "$[i*j]"
                    end
                echo -en '\n'               #add zero string
                end
        else
            if ( "$1" < "$2" ) then
            foreach
                foreach i in $(seq $1 $2)
                    
                    echo "$[i*j]"
                    end
                echo -en '\n'               #add zero string
                end
             else
             foreach j in $(seq $2 $1)        #multiplication table from $2 to $1                 
                foreach i in $(seq $2 $1)
                    echo "$[i*j]"
                    end
                echo -en '\n'               #add zero string
                end
             endif
        endif
    else
    echo "One of arguments is not numeric"
    endif
endif






