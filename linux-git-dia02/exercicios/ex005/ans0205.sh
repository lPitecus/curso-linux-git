#!/bin/bash

# Criar uma função marco que salva o diretório atual
# Criar uma função polo que muda para o diretório salvo pela função

marco() {
  dir_salvo=$(pwd)
  echo "O diretório foi salvo com sucesso! Caminho do diretório salvo: $dir_salvo"
}

polo() {
  if [ $(pwd) = $dir_salvo ]; then
    echo "Você já está no diretório salvo!"
    return
  fi
  cd "$dir_salvo"
}
