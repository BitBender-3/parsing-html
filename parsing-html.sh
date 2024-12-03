#!/bin/bash

# Set the colors
GREEN="\e[34m"
RESET="\e[0m" # Reset the color to default


if [ -z "$1" ];
then
	echo -e "${GREEN}#########################################################"
	echo 	"|->		       PARSING HTML                   <-|"
	echo 	"|-> 	    ./parsing-html.sh www.target.com          <-|"
	echo -e "#########################################################${RESET}"
else
	echo -e "${GREEN}#########################################################"
	echo    "|->	             Searching Hosts...               <-|"
	echo -e "#########################################################${RESET}"

	# Try to download the url with timeout
	wget --timeout=10 --spider "$1" 2> /dev/null || { echo "Error: URL does not exist."; exit 1; }

	# Whether has success it download the source code of page
	hosts=$(wget -qO- "$1" | grep href | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | grep -v "<l")

	echo "$hosts"

	echo -e "${GREEN}#########################################################"
	echo    "|->                   Resolving Hosts                <-|" 
	echo -e "#########################################################${RESET}"


	# Resolve the domans
	for url in $hosts; do
	   host $url | grep "has address"
	done
fi

