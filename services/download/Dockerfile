FROM bash:alpine3.19

RUN apk update && apk add parallel aria2
COPY . /docker
# Копируем модели из хоста (sd-models) в контейнер
# Копируем модели в нужную директорию при сборке
RUN ls
RUN chmod +x /docker/download.sh
ENTRYPOINT ["/docker/download.sh"]
