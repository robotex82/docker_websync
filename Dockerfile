FROM ubuntu:14.04

MAINTAINER Roberto Vasquez Angel <roberto@vasquez-angel.de>

# Add user docker =============================================================

# Create home folder
RUN mkdir -p /home/docker

# Add user docker
RUN useradd -m docker -d /home/docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Add docker to sudoers without password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set correct rights on /home/docker
RUN chown docker:docker /home/docker

# Use docker user from now on
USER docker

# Install prerequisites =======================================================

# Install git
RUN sudo apt-get install -y git

# Install curl
RUN sudo apt-get install -y curl

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash - && sudo apt-get install -y nodejs

# Install websync dependencies
RUN sudo apt-get install -y sshpass

# Install node-gyp
RUN sudo apt-get install -y g++ && sudo npm install node-gyp

# Install python 2.7
RUN sudo apt-get install -y software-properties-common && sudo add-apt-repository ppa:fkrull/deadsnakes && sudo apt-get update && sudo apt-get install -y python2.7

# Set Python path
RUN echo 'PYTHON=/usr/bin/python2.7' | sudo tee --append /etc/environment > /dev/null

# Install make
RUN sudo apt-get install -y make

# Install bower
RUN sudo npm install -g bower

# Install gulp
RUN sudo npm install -g gulp

# Install websync =============================================================

# Download websync
RUN cd && git clone https://github.com/furier/websync.git

# Install websync dependencies
RUN cd ~/websync && sudo PYTHON=/usr/bin/python2.7 npm install

# Install dependencies via bower
RUN cd ~/websync && bower install

# Build websync
RUN cd ~/websync && gulp dist || true && rm -rf ./dist && gulp dist