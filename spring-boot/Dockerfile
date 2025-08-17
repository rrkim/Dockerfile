FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Seoul

RUN apt-get update && apt-get install -y ssh vim curl wget git net-tools zip tar tzdata gnupg jq
RUN mkdir -p /run/sshd

RUN apt-get update && apt-get install -y \
    locales \
    && locale-gen ko_KR.UTF-8 \
    && update-locale LANG=ko_KR.UTF-8

ENV LANG=ko_KR.UTF-8 \
    LANGUAGE=ko_KR:ko \
    LC_ALL=ko_KR.UTF-8

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb stable main" \
     > /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get install -y google-chrome-stable \
  && rm -rf /var/lib/apt/lists/*

RUN CHROME_MAJOR="$(google-chrome --version | awk '{print $3}' | cut -d. -f1)" \
 && JSON_URL="https://googlechromelabs.github.io/chrome-for-testing/latest-versions-per-milestone-with-downloads.json" \
 && DRIVER_ZIP_URL="$(curl -sS "$JSON_URL" \
      | jq -r --arg m "$CHROME_MAJOR" '.milestones[$m].downloads.chromedriver[] | select(.platform=="linux64") | .url')" \
 && curl -sSL "$DRIVER_ZIP_URL" -o /tmp/chromedriver.zip \
 && unzip /tmp/chromedriver.zip -d /usr/bin/ \
 && mv /usr/bin/chromedriver-linux64/chromedriver /usr/bin/chromedriver \
 && rm -rf /usr/bin/chromedriver-linux64 \
 && chmod +x /usr/bin/chromedriver \
 && rm -rf /tmp/chromedriver.zip
  
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
