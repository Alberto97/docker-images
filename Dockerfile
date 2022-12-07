FROM fedora:latest

# Install packages
RUN \
  echo "**** install packages ****" && \
  dnf install -y \
    git \
    python \
    rpmdevtools
