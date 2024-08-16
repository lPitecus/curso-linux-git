#!/bin/bash

# Função para exibir a ajuda
show_help() {
  echo "Bem vindo ao password-generator! Versão 1.0"
  echo "Uso: $0 [OPÇÕES]"
  echo "Opções:"
  echo "  -l [COMPRIMENTO] : comprimento da senha"
  echo "  -u               : incluir letras maiúsculas"
  echo "  -d               : incluir números"
  echo "  -s               : incluir símbolos"
  echo "  -h               : exibir essa mensagem de ajuda"
}

# Definir variáveis padrão
LENGTH=8
USE_UPPERCASE=false
USE_DIGITS=false
USE_SYMBOLS=false

# Parsear argumentos
while getopts ":l:uds" option; do
  case $option in
  l) LENGTH=$OPTARG ;;
  u) USE_UPPERCASE=true ;;
  d) USE_DIGITS=true ;;
  s) USE_SYMBOLS=true ;;
  h)
    show_help
    exit
    ;;
  *)
    show_help
    exit
    ;;
  esac
done

# Definir conjuntos de caracteres
LOWERCASE="abcdefghijklmnopqrstuvwxyz"
UPPERCASE="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
DIGITS="0123456789"
SYMBOLS="!@#$%^&*()-_=+[]{}|;:,.<>?/~"

# Construir a lista de caracteres permitidos
CHAR_POOL=$LOWERCASE
if $USE_UPPERCASE; then
  CHAR_POOL+=$UPPERCASE
fi
if $USE_DIGITS; then
  CHAR_POOL+=$DIGITS
fi
if $USE_SYMBOLS; then
  CHAR_POOL+=$SYMBOLS
fi

# Gerar a senha
PASSWORD=$(head /dev/urandom | tr -dc "$CHAR_POOL" | head -c $LENGTH)

# Exibir a senha gerada
echo "Senha gerada: $PASSWORD"

# Opcional: salvar a senha em um arquivo criptografado
if [ "$STORE_PASSWORD" == "true" ]; then
  echo -n "Digite o nome do arquivo para salvar a senha: "
  read FILENAME
  echo -n "Senha de criptografia: "
  read -s ENCRYPTION_PASSWORD
  echo
  echo "$PASSWORD" | openssl enc -aes-256-cbc -e -out "$FILENAME" -pass pass:$ENCRYPTION_PASSWORD
  echo "Senha salva e criptografada em $FILENAME"
fi
