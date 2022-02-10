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
    if ! [ -z "$1" ] ; then
        initialFolder=$1
    fi
    # para todos os arquivos na lista 
    # TODO -c "Arrumar Lista" -t ARRUMAR
    for element in $(ls "$initialFolder"); do
        if [ -f $element ]; then
            arquivos+=("$element")
        fi
    done
    seq -n /"# TODO"/p $arquivos
}

# MANIPULACAO DE ARRAY
# arquivos=()                  # cria o array
# arquivos+=("readme.md")      # add objeto to array
# arquivos+=("todolist.sh")    # add objeto to array
# ${#arquivos[@]}              # retorna o tamanho do array


# Manipulação de TODOS com SED
# cat utils.sh | sed -n '/^# TODO/p' 
# sed -n '/^# TODO/p' < utils.sh
# sed -n '/^# TODO/p' < utils.sh >> TodoList ; cat TodoList