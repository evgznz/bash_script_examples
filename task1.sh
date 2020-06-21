#!/bin/bash
#
#   ./task1.sh  \*  - для удаления из домашней директории файлов начинающихся с _
#   ./task1.sh file1 file2 file2 .... для удаления файлов из домашней директории
#    Удаление происходит без рекурсии
#

set -f 
function printf {
	echo -e  $1
	}

function name_prog {
	name=$1

        num=`echo $HOME | wc -c`
        echo ${name:num}
	}

function delete_file {

  printf "Удаляем файл $HOME/$1 "
  if [[ -f $HOME/$1 ]]  

  	then
	     printf "Удалили файл rm  $HOME/$1 "
	     rm  $HOME/$1
	else

	    printf " файл не существует $HOME/$1"
  fi
}

for i in  ${@}
do
	echo $i
	if [[ $i == '*' ]]
	then
		printf "Звезда"
		file=`find $HOME -maxdepth 1 -type f  -name  "_*" -print`
	       	name_file=$(name_prog $file)
		delete_file $name_file

	else

		file=`find $HOME -maxdepth 1 -type f  -name    $i -print`
		name_file=$(name_prog $file)
		delete_file $name_file

	fi

done
#echo -e  ${@}
