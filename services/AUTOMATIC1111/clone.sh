#!/bin/bash

set -Eeuox pipefail

mkdir -p /repositories/"$1"
cd /repositories/"$1"
export GIT_TRACE_PACKET=1
export GIT_TRACE=1
export GIT_CURL_VERBOSE=1
git config --global core.compression 0
git init
git remote add origin "$2"
git fetch origin "$3" --depth=1 || (sleep 5 && git fetch origin "$3" --depth=1)
# Проверяем статус после выполнения команды
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении git fetch"
    exit 1
fi

git reset --hard "$3"

# Проверяем статус после выполнения команды
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении git reset"
    exit 1
fi
rm -rf .git
