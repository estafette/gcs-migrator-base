FROM python:3.11-alpine

RUN apk update && \
    apk add binutils build-base git cmake automake autoconf && \
    rm -rf /var/cache/apk/*

RUN pip install wheel patchelf-wrapper SCons

RUN pip install staticx

RUN git clone https://github.com/NixOS/patchelf.git /tmp/patchelf && \
      cd /tmp/patchelf && \
      ./bootstrap.sh && \
      ./configure && \
      make && \
      make check && \
      make install && \
      cd /root && \
      rm -rf /tmp/patchelf

COPY requirements.txt /tmp

RUN pip install -r /tmp/requirements.txt && \
    rm -rf /tmp/requirements.txt

