ARG IMAGE_TYPE=community
FROM localstack/localstack:1.3.1 as build
EXPOSE 4566 4510-4559

RUN mkdir /usr/local/nvm

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 16.18.0
ENV NVM_INSTALL_PATH $NVM_DIR/versions/node/v$NODE_VERSION

ADD scripts/localstack/start-services.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start-services.sh

RUN rm /bin/sh && ln -s /bin/bash /bin/sh \
    && apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean \
    && apt-get install -y git-all rustc \
    && curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_INSTALL_PATH/lib/node_modules
ENV PATH $NVM_INSTALL_PATH/bin:$PATH

# Package AWS CLI & Configure
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

ENTRYPOINT ["docker-entrypoint.sh"]
