FROM buildpack-deps:buster-curl

LABEL maintainer="lx-dev-pm <lx-dev@pm.me>"

RUN apt-get update && apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends gcc clang make git && \
    apt-get clean && rm -rf /var/cache/apt/archives/* && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/vlang/v.git /opt/vlang

RUN cd /opt/vlang && make && ./v symlink

WORKDIR /app