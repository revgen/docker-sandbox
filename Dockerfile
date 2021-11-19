FROM ubuntu:20.04

ARG VERSION="1.0.0"
ARG BUILD_DATE="2021-09-19"


LABEL maintainer="Evgen Rusakov" \
      image.description="Docker image with developer sandbox, based on Ubuntu Linux" \
      url.docker="https://hub.docker.com/r/rev9en/sandbox" \
      url.source="https://github.com/revgen/docker-sandbox" \
      image.version=$VERSION \
      image.date=$BUILD_DATE

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    \
    apt -y install tzdata && \
    unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/America/New_York /etc/localtime && \
    \
    apt -y install sudo neovim git curl wget less tree unzip jq screen && \
    apt -y install tig dialog figlet lynx elinks && \
    apt -y install software-properties-common && \
    apt -y install telnet && \
    apt -y install iputils-ping && \
    apt -y install dnsutils && \
    \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt -y install python3.9 python3-pip && \
    \
    pip install requests python-dotenv && \
    pip install pylint pylint-quotes pylint-unittest && \
    \
    curl -sL https://dl.google.com/go/go1.17.1.linux-amd64.tar.gz | tar -xz -C /usr/local && \
    echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile.d/golang.sh && \
    \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt -y install nodejs && \
    npm install -g dotenv && \
    \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "aws.zip" && \
    unzip aws.zip && sudo ./aws/install && rm -r aws* && \
    \
    apt -y install default-jdk && \
    \
    apt -y install docker.io && \
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    \
    rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/dev -s /bin/bash -m dev && \
    usermod -a -G sudo dev && \
    usermod -a -G docker dev && \
    echo "dev:devNow" | chpasswd && \
    echo "OK"

USER dev
WORKDIR /home/dev

# We need a full interactive login shell inside this image
CMD ["bash", "--login"]
