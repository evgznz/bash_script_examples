#!/bin/bash

function printf {
	echo -e   $1
	}

function home_dir {

	sudo=$1
	home_dir=`$suod grep 'www-data' /etc/passwd | awk -F ':' '{ print $6 }'`
	printf "$sudo $home_dir"
}
if [[ `id -u` -eq 0 ]]
	then

		home_dir
	else
		home_dir sudo
	
fi
#home_dir=`$suod grep 'www-data' /etc/passwd | awk -F ':' '{ print $6 }'`
#printf $home_dir
