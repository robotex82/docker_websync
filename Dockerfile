FROM ubuntu:14.04

# Install git
RUN apt-get install -y git

# Install curl
RUN apt-get install -y curl

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash - && sudo apt-get install -y nodejs

# Install websync dependencies
RUN apt-get install -y sshpass

# Download websync
RUN git clone https://github.com/furier/websync.git