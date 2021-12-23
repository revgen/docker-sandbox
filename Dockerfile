FROM ubuntu:20.04

ARG BUILD_VERSION="1.0.1"
ARG BUILD_DATE="2021-12-23"
ARG IMAGE_NAME="rev9en/sandbox"

ARG GO_VERSION=1.17.1
ARG PYTHON_VERSION=3.9
ARG NODE_VERSION=14
ARG DEVUSER=dev

LABEL maintainer="Evgen Rusakov" \
      image.description="Docker image with developer sandbox, based on Ubuntu Linux" \
      url.docker="https://hub.docker.com/r/${IMAGE_NAME}" \
      url.source="https://github.com/revgen/docker-sandbox" \
      image.version=${BUILD_VERSION} \
      image.date=${BUILD_DATE}

ENV DEBIAN_FRONTEND=noninteractive
ENV IMAGE_NAME=${IMAGE_NAME}
ENV BUILD_VERSION=${BUILD_VERSION}

ENV AWS_DEFAULT_PROFILE=default
ENV AWS_DEFAULT_REGION=us-east-1
ENV AWS_REGION=${AWS_DEFAULT_REGION}
ENV TZ=America/New_York

RUN apt update && \
    \
    apt -y install tzdata && \
    \
    apt -y install sudo neovim openssl git tig curl wget less tree unzip jq screen && \
    apt -y install tig dialog lynx elinks && \
    apt -y install software-properties-common && \
    apt -y install telnet iputils-ping dnsutils && \
    \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt -y install python${PYTHON_VERSION} && \
    apt -y install python3-pip && \
    pip3 install --upgrade pip && \
    pip3 install --upgrade setuptools && \
    which python >/dev/null || ln -sv $(which python3) /usr/bin/python && \
    which pip >/dev/null || ln -sv $(which pip3) /usr/bin/pip && \
    \
    curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt -y install nodejs && \
    \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g dotenv

RUN pip install requests python-dotenv && \
    pip3 install pytest pytest-cov pytest-mock pytest-ordering && \
    pip3 install pylama pycodestyle pylint pylint-quotes pylint-unittest pylint-pytest && \
    pip3 install mypy black isort

COPY ./root-fs/ /

RUN useradd -d /home/${DEVUSER} -s /bin/bash -m ${DEVUSER} && \
    addgroup --gid 107 docker && \
    usermod -a -G sudo,docker ${DEVUSER} && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo "${DEVUSER}:${DEVUSER}123" | chpasswd && \
    chown ${DEVUSER}:${DEVUSER} -R /home/${DEVUSER} && \
    echo "OK"

USER ${DEVUSER}
WORKDIR /home/${DEVUSER}

# We need a full interactive login shell inside this image
CMD ["bash", "--login"]
