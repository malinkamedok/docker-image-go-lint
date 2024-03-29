FROM ubuntu:23.10@sha256:50ec5c3a1814f5ef82a564fae94f6b4c5d550bb71614ba6cfe8fadbd8ada9f12
ARG GO_VERSION=go1.22.1
RUN apt update -y -q && apt upgrade -y -q

ENV DEBIAN_FRONTEND noninteractive

RUN apt install --no-install-recommends -y -q \
    curl \
    ca-certificates

RUN useradd -ms /bin/bash ci

# Install Go
RUN curl -s https://dl.google.com/go/${GO_VERSION}.linux-amd64.tar.gz | tar xz -C /usr/local
ENV PATH $PATH:/usr/local/go/bin

RUN curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/go/bin v1.57.2

USER ci