#!/bin/bash

function help {
		echo "$0  Команды , которые нужно выполнить и IP адрес удаленного сервера\n"
		echo "$0   \"ps  ; id -u; uptime\"  127.0.0.1"
	}


function connect_ssh {
	ssh  $@
}
	
if [[ $# -eq 0 ]] 
	then

		help
	else
		args=($@)
		num=${#args[@]}
		ip_address=${args[$num-1]}
		command=`echo $@ | sed "s/$ip_address//g" `
		echo $command
		connect_ssh $ip_address $command

fi

