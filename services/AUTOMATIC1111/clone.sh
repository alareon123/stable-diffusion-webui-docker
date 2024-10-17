#!/bin/bash

set -Eeuox pipefail
export GIT_TRACE_PACKET=1
export GIT_TRACE=1
export GIT_CURL_VERBOSE=1

# Увеличение буфера и тайм-аутов для Git
git config --global http.postBuffer 1048576000
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999
git config --global core.compression 0

# Создаём папку для репозитория
mkdir -p /repositories/"$1"
cd /repositories/"$1"

# Инициализируем репозиторий
git init

# Добавляем удалённый репозиторий
git remote add origin "$2"

# Выполняем fetch с повторными попытками
for i in {1..5}; do
    git fetch origin "$3" --depth=1 && break || sleep 10
done

# Проверяем успешность выполнения команды
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении git fetch"
    exit 1
fi

# Переключаемся на коммит
git reset --hard "$3"

# Проверяем успешность выполнения команды
if [ $? -ne 0 ]; then
    echo "Ошибка при выполнении git reset"
    exit 1
fi

# Удаляем .git только после успешного завершения всех команд
rm -rf .git
