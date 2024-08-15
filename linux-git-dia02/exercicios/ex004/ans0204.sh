#!/bin/bash

# receber como argumento um arquivo ou diretorio
# se for diretorio -> copiar o diretorio e todos os arquivos e pastas dentro
# se for arquivo -> apenas criar outro arquivo
# Criar dentro do mesmo local que o script for executado

if [ -f "$1" ]; then
  cp "$1" "$1.bak"
elif [ -d "$1" ]; then
  cp -r "$1" "$1.bak"
fi
