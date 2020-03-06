FROM emilioag/rocksdb:latest

FROM python:3.8.2-slim-buster

ARG BUILD_DEPS='build-essential'
ARG FAUST_EXTENSIONS='fast,rocksdb'

COPY --from=0 /usr /usr

ADD requirements.txt /tmp/requirements.txt

RUN apt-get update && \
    apt-get install -y ${BUILD_DEPS} && \
    pip --no-cache-dir install faust[${FAUST_EXTENSIONS}]&& \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get purge -y --auto-remove ${BUILD_DEPS}
