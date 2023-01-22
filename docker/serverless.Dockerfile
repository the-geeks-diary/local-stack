FROM debian:bullseye-slim as environment

ARG SERVERLESS_VERSION=3.26.0
ARG NODE_VERSION=16.18.0
ARG NVM_VERSION=0.39.3
ARG YARN_VERSION=3.3.1

ENV SERVERLESS_VERSION $SERVERLESS_VERSION
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION $NODE_VERSION
ENV NVM_INSTALL_PATH $NVM_DIR/versions/node/v$NODE_VERSION
ENV NVM_VERSION $NVM_VERSION
ENV YARN_VERSION $YARN_VERSION

RUN rm /bin/sh && ln -s /bin/bash /bin/sh \
    && apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean \
    && apt-get install -y git-all rustc
    # && curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash
    # && apt-get install -y python2 python3 python3-dev py-pip ca-certificates groff less bash make jq curl wget g++ zip git openssh \
    # && pip --no-cache-dir install awscli && \
    # update-ca-certificates


RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default
# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_INSTALL_PATH/lib/node_modules
ENV PATH $NVM_INSTALL_PATH/bin:$PATH

# ENABLE YARN PACKAGE MANAGER & INSTALL SERVERLESS
RUN corepack enable \
    && corepack prepare yarn@${YARN_VERSION} --activate \
    && yarn global add serverless@${SERVERLESS_VERSION}
