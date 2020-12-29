#!/bin/bash

# Pavel Hryshunin

help_report="\nProgram return authorizated username\n\nAvailable options:\n  -h [--help]\n  -q [--qiet]\n\n"  
is_quiet=false
is_help=false
is_valid_cmd=false

#block of options
for var in "$@"
do
    if [[ $var == "-h" ]] || [[ $var == "--help" ]]; then is_help=true; fi
	if [[ $var == "-q" ]] || [[ $var == "-quiet" ]]; then is_quiet=true; fi
	if [ ${var:0} == "-" ]; then is_valid_cmd=true; fi
done

if $is_help; then echo -e "${help_report}"; exit 0; fi	
if $is_quiet; then exit 0; fi
if $is_valid_cmd; then echo -e "\n$var: invalid command\n"; echo -e "${help_report}"; exit 1; fi

#block getting user name
user_data="$(getent passwd $USER)" #get the list of user credentials

IFS=':'                       #divide elements in the list by sign ':'
read -ra el <<< "$user_data" 

user_name=${el[4]%???}  #get 4th element from the list of user credentials without 3 last signs(,,,) after passwd
echo ${user_name}  

