FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

RUN apt-get update && apt-get install -y ssh vim curl wget git net-tools zip tar tzdata
RUN mkdir -p /run/sshd

RUN apt-get update && apt-get install -y \
    locales \
    && locale-gen ko_KR.UTF-8 \
    && update-locale LANG=ko_KR.UTF-8

ENV LANG=ko_KR.UTF-8 \
    LANGUAGE=ko_KR:ko \
    LC_ALL=ko_KR.UTF-8

WORKDIR /home/app/

RUN mkdir -p /home/app/bin/
RUN mkdir -p /home/app/data/

RUN curl -o zulu.tar.gz "https://cdn.azul.com/zulu/bin/zulu17.52.17-ca-jdk17.0.12-linux_x64.tar.gz" \
    && tar -xzf zulu.tar.gz \
    && rm zulu.tar.gz \
    && mv $(ls -d */ | grep zulu) bin/zulu17

RUN mkdir /root/.ssh
COPY ./authorized_keys /root/.ssh/

COPY ./*.sh /home/app/bin/
COPY ./application.jar /home/app/application.jar
RUN mkdir /home/app/data/_upload/
RUN chmod 755 /home/app/bin/*.sh

EXPOSE 8080
EXPOSE 22

CMD ["/bin/bash", "-c", "/home/app/bin/on_boot.sh && /usr/sbin/sshd && tail -f /dev/null"]