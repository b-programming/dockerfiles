# set the base image to Debian
# https://hub.docker.com/_/debian/
FROM bprogramming/dev_ubuntu:latest

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# nvm environment variables
#ENV NVM_DIR /usr/local/nvm

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 12.14.1

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install --lts \
    && nvm alias default lts/* \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

#add git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git
    
#confirm
RUN node -v
RUN npm -v
RUN git --version
