#!/bin/bash

domain="test4.my2ip.ru"

dns1="77.88.8.8"
dns2="8.8.8.8"

num_package=2

function printf {
	echo -e   $@
	}
function help {
	 printf "\nОпределение доступности A записей для домена\n "
	 printf " Методом nslookup\t $0  \"любой домен\""
	 printf "\nУстановка пакета dig:\t\tsudo apt-get install dnsutils"
	  
}
function check_http {
	domain="http://$2"
	curl --dns-servers $1 --write-out %{http_code} --silent --output /dev/null $domain
	#curl --dns-servers 77.88.8.8  --write-out %{http_code} --silent --output /dev/null  http://test4.my2ip.ru
}

function check_check_record_a {
	printf "\tОтправляем PING пакеты в количестве $num_package шт на IP Адрес  сервера $1"
	ping -c $num_package $1 > /dev/null 2>/dev/null
	if 	[[ $? -eq 0 ]] 
	then
		printf "\t\nIP адрес $1 доступен!!"
		printf "\tПроверяем домен http://$2 STATUS CODE для HTTP $(check_http $1 $2)\n"
	else
		printf "\t\t Мы кажется его потеряли :("

	fi
}

function nslookup_dns {

        records_a=`nslookup $1  $2  | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"| sed "s/$2//g"`

	printf "\n\nМетод:\tnslookup $1 $2"
	printf "\tСписок A записей для домена $1\t $records_a"
	for i in $records_a
	do
		check_check_record_a $i $1
	done

}

function dig_dns {
	records_a=`dig @$2 +short $1 `

	printf "\n\nМетод:\tdig @$2  +short $1"
	printf "\tСписок A записей для домена $1\t $records_a"
	for i in $records_a
	do
		check_check_record_a $i $1
	done

}
if [[  $# -eq 0 ]]
	then 	
		printf "Запуск с параметрами по умолчнию $0 $domain\n"
		nslookup_dns $domain $dns1
		nslookup_dns $domain $dns2

		dig_dns $domain $dns1
		dig_dns $domain $dns2
elif [[ $# -eq 1 ]]
	then 
		domain="$1"
		printf "Запуск с для домена $domain\n"
		nslookup_dns $domain $dns1
		nslookup_dns $domain $dns2
		dig_dns $domain $dns1
		dig_dns $domain $dns2

	help
fi

