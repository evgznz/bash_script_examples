#!/bin/bash

function help {
		echo "$0  Команды , которые нужно выполнить и IP адрес удаленного сервера\n"
		echo "$0 ps id df ls 127.0.0.1"
	}

function connect_ssh {
	ssh $1 $2
}
if [[ $# -eq 0 ]] 
	then

		help
	else
		args=($@)
		num=${#args[@]}
		echo $num
		for (( i=0 ;i<$num-1;i++))
			do		
				connect_ssh ${args[$num-1]} ${args[$i]}
			done
	fi

