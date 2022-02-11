#!/bin/bash
f="/mnt/c/Users/marcio.souza/projetos/montarDiscos"
d="1"
mapfile arquivos <<< "$(find "$f" -maxdepth "$d" ! -type d)"
for arquivo in "${arquivos[@]}"; do
	echo "--------------------"
	arquivo="$(tr -d '\n' <<< "$arquivo")"
	echo "$arquivo"
	echo "$(sed -e 's/# TODO //' <<< "$(sed -n '/# TODO/p' < "$arquivo")")"
done



