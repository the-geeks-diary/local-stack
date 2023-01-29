FROM ubuntu:22.04 as environment

ARG SERVERLESS_VERSION=3.26.0
ARG NODE_VERSION=16.18.0
ARG NVM_VERSION=0.39.3
ARG YARN_VERSION=3.3.1

RUN mkdir /usr/local/nvm

ENV SERVERLESS_VERSION $SERVERLESS_VERSION
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION $NODE_VERSION
ENV NVM_INSTALL_PATH $NVM_DIR/versions/node/v$NODE_VERSION
ENV NVM_VERSION $NVM_VERSION
ENV YARN_VERSION $YARN_VERSION

RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=America/New_York apt-get -y install tzdata

RUN rm /bin/sh && ln -s /bin/bash /bin/sh \
    && apt-get update \
    && apt-get -y install software-properties-common && apt-get update \
    && add-apt-repository universe \
    && apt-get -y install curl git-all rustc python2 python3 python3-dev python3-pip ca-certificates groff less make jq wget g++ zip openssh-server \
    && curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_INSTALL_PATH/lib/node_modules
ENV PATH $NVM_INSTALL_PATH/bin:$PATH

# ENABLE YARN PACKAGE MANAGER & INSTALL SERVERLESS
RUN corepack enable \
    && corepack prepare yarn@$YARN_VERSION --activate \
    && npm install -g aws-cli \
    && npm install -g serverless@$SERVERLESS_VERSION \
    && update-ca-certificates
