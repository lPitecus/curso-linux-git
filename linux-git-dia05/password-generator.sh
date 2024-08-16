#!/bin/bash

# Função para exibir a ajuda
show_help() {
	echo "Bem vindo ao password generator! Versão 1.1, (c) 2024, DIMAp, UFRN"
	echo "Uso ./password-generator.sh [OPTIONS]"
	echo "Opções:"
	echo "  -l LENGTH  Especifica o tamanho da senha (padrão: 8)"
	echo "  -u         Inclui letras maiúsculas na senha"
	echo "  -d         Inclui dígitos na senha"
	echo "  -s         Inclui símbolos na senha"
	echo "  -h         Exibe essa ajuda"
	echo "  -o         Salva a senha gerada em um arquivo"
	echo "  -n NAME    Adiciona um nome a senha gerada"
	echo "  -p         Exibe senhas geradas"
}

# Definir variáveis padrão
LENGTH=8
USE_UPPERCASE=false
USE_DIGITS=false
USE_SYMBOLS=false

# Parsear argumentos
while getopts ":l:udsn:op" option; do
	case $option in
	o) SAVE_PASSWORD=true ;;
	n) PASSWORD_NAME=$OPTARG ;;
	p) SHOW_PASSWORDS=true ;;
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

# Armazenar a senha em um arquivo, se a opção -o for passada
if [ "$SAVE_PASSWORD" == true ]; then
	if [ -n "$PASSWORD_NAME" ]; then
		echo "$PASSWORD_NAME: $PASSWORD" >>$OUTPUT_FILE
	else
		echo "$PASSWORD" >>$OUTPUT_FILE
	fi
fi

# Mostrar senhas armazenadas
if [ "$SHOW_PASSWORDS" == true ]; then
	if [ -f "$OUTPUT_FILE" ]; then
		cat "$OUTPUT_FILE"
	else
		echo "Nenhuma senha armazenada."
	fi
	exit 0
fi

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
