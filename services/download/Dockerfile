FROM bash:alpine3.19

RUN apk update && apk add parallel aria2
COPY . /docker
# Копируем модели из хоста (sd-models) в контейнер
# Копируем модели в нужную директорию при сборке
RUN mkdir -p /data/models/Stable-diffusion && \
    cp -r /tmp/sd-models/* /data/models/Stable-diffusion/
RUN chmod +x /docker/download.sh
ENTRYPOINT ["/docker/download.sh"]
