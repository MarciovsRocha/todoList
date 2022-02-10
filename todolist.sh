#! /bin/bash

if [ -f /storage/utils.sh ]
then 
    source /storage/utils.sh
else 
    echo "Arquivo de \"Utils.sh\" não encontrado."
    exit 1 
fi

# passe somente 1 parâmetro (opcional) sendo o mesmo a pasta 
# em que será iniciada a busca de arquivos
function listar_arquivos(){
    arquivos=()
    initialFolder="./"
    if [ -z ne "$1" ] 
        $initialFolder=
    for element in $(ls $initialFolder);
}


arquivos=()

for element in $(ls); do
    if check_file $element

done
