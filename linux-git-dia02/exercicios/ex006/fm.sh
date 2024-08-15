#!/bin/bash

# Função para exibir a ajuda
mostrar_ajuda() {
  echo "Usage: $0 [OPTION]... FILE..."
  echo "  -h, --help    Show this help message"
  echo "  -l, --list    List all files in the current directory"
  echo "  -c, --create  Create a new file"
  echo "  -d, --delete  Delete a file"
}

while getopts ":lh:c:d:" opt; do
  case ${opt} in
  h)
    mostrar_ajuda
    ;;
  l)
    ls
    ;;
  c)
    echo "você quer criar um aqruivo chamado ${OPTARG}"
    ;;
  d)
    echo "você quer deletar o arquivo ${OPTARG}"
    ;;
  ?)
    echo "Opção inválida: -${OPTARG}"
    exit 1
    ;;
  esac
done
