#!/bin/bash
f="/mnt/c/Users/marcio.souza/projetos/montarDiscos"
d="1"
export=1
while getopts "f: d: :e" flag; do
	case "${flag}" in
		f)
			f="${OPTARG}"
			;;
		d)
			d=${OPTARG}
			;;
		e)
			export="0"
			;;
		*)
			echo "Parametro '${flag}' incorreto."
			;;
	esac
done

if ! [ -d "$f" ] || [ -z "$f" ] ; then
	echo "Pasta '$f' inválida."
else
	mapfile arquivos <<< "$(find "$f" -maxdepth "$d" ! -type d)"
	for arquivo in "${arquivos[@]}"; do
		arquivo="$(tr -d '\n' <<< "$arquivo")"
		content="$(sed -e 's/# TODO //' <<< "$(sed -n '/# TODO/p' < "$arquivo")")"
		if ! [ -z "$content" ] ; then
			if [ "${export}" ] ; then
				echo '--------------------' >> todoList.txt
				echo "$arquivo" >> todoList.txt
				echo "$( tr '\r' '\n' <<< "$content")" >> todoList.txt
			fi
			echo -e "--------------------\n${arquivo}\n${content}"
		fi
	done
fi


