#!/bin/bash

# Função para exibir a ajuda
show_help() {
  echo "Usage: $0 [OPTION]... FILE..."
  echo ""
  echo "Options:"
  echo "  -h, --help     Show this help message and exit"
  echo "  -l, --list     List all files in the current directory"
  echo "  -c, --create   Create a new file"
  echo "  -d, --delete   Delete a file"
}

# Função para listar arquivos no diretório atual
list_files() {
  echo "Files in the current directory:"
  ls -1
}

# Função para criar arquivos
create_file() {
  for file in "$@"; do
    if [ -e "$file" ]; then
      echo "File '$file' already exists."
    else
      touch "$file"
      echo "File '$file' created."
    fi
  done
}

# Função para deletar arquivos
delete_file() {
  for file in "$@"; do
    if [ -e "$file" ]; then
      rm "$file"
      echo "File '$file' deleted."
    else
      echo "File '$file' does not exist."
    fi
  done
}

# Se nenhum argumento for passado, mostrar a ajuda
if [ $# -eq 0 ]; then
  show_help
  exit 1
fi

# Arrays para armazenar opções e arquivos
declare -a files
declare -a options

# Separar as opções dos arquivos
while (( "$#" )); do
  case "$1" in
    -h|--help)
      show_help
      exit 0
      ;;
    -l|--list)
      options+=("list")
      shift
      ;;
    -c|--create)
      options+=("create")
      shift
      ;;
    -d|--delete)
      options+=("delete")
      shift
      ;;
    *)
      files+=("$1")
      shift
      ;;
  esac
done

# Executar as opções
for option in "${options[@]}"; do
  case "$option" in
    list)
      list_files
      ;;
    create)
      if [ ${#files[@]} -eq 0 ]; then
        echo "No files specified for creation."
      else
        create_file "${files[@]}"
      fi
      ;;
    delete)
      if [ ${#files[@]} -eq 0 ]; then
        echo "No files specified for deletion."
      else
        delete_file "${files[@]}"
      fi
      ;;
  esac
done

