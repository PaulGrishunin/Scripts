#!/bin/tcsh

#Pavel Hryshunin, grupa 1

set help_report = "Program return authorized username\Available options:  -h [--help]  -q [--quiet]"  

#block of options
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

#block getting user name
set user_data = "`getent passwd $user`"
set el = ($user_data:as/:/ /)

set user_name = "${el[5]} ${el[6]}"
echo $user_name
