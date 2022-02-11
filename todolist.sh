#! /bin/bash

if [ -f /storage/scripts/utils.sh ]
then 
    # shellcheck source=/dev/null
    source /storage/scripts/utils.sh
else 
    echo "[todoList.sh gerou um erro]: Arquivo de \"Utils.sh\" não encontrado." >> "logs/$(date '+%Y%m%d_%H%M%S').log"
fi

# função para listar todos os arquivos na pasta passada atual ou
# na pasta passada pelo argumento -f 
listar_arquivos(){
    f=$(pwd)
    e=1
    d=1
    while getopts f:d:e: flag; do
        case "${flag}" in
            f)
                f=${OPTARG}
                ;;
            d)
                d=${OPTARG}
                ;;
            e)
                e=${OPTARG}
                ;;
            *)
                "$msgFolder"/parametro_incorreto
#                exit 1
                ;;
        esac
    done

    # valida se o valor passado pela flag -f é um diretório válido
    check_dir $f
    test=$?
    if [ 1 == "$test" ] ; then 
        "$msgFolder"/diretorio_nao_encontrado
#        exit 1
    fi

    # valida se o valor passado pela flah -d é um inteiro positivo
    isnumber $d
    test=$?
    if [ 1 == "$test" ] ; then
        "$msgFolder"/parametro_incorreto
#        exit 1
    fi

    mapfile arquivos <<< "$(find "$f" -maxdepth "$d" ! -type d)"

    if [ 0 == "$e" ] ; then 
        for arquivo in "${arquivos[@]}" ; do
            arquivo="$(tr -d '\n' <<< "$arquivo")"
            echo "-----------"
            echo "$arquivo" >> todos.txt
            echo "$(sed -e 's/# TODO //' <<< "$(sed -n '/^# TODO/p' < "${arquivo}")")" >> todos.txt
        done
    fi

    for arquivo in "${arquivos[@]}" ; do
        arquivo="$(tr -d '\n' <<< "$arquivo")"
        echo "-----------"
        echo "$arquivo"
        echo "$(sed -e 's/# TODO //' <<< "$(sed -n '/^# TODO/p' < "${arquivo}")")"
    done
}

#arquivo="$(pwd)/utils.sh"
#echo "$(sed -e 's/# TODO //' <<< $(sed -n '/^# TODO/p' < "${arquivo}"))"


# MANIPULACAO DE ARRAY
# arquivos=()                  # cria o array
# arquivos+=("readme.md")      # add objeto to array
# arquivos+=("todolist.sh")    # add objeto to array
# ${#arquivos[@]}              # retorna o tamanho do array


# Manipulação de TODOS com SED
# cat utils.sh | sed -n '/^# TODO/p' 
# sed -n '/^# TODO/p' < utils.sh
# sed -n '/^# TODO/p' < utils.sh >> TodoList ; cat TodoList