FROM emilioag/rocksdb as build
FROM python:3.8.2-slim-buster

ARG BUILD_DEPS='build-essential'

COPY --from=build /usr /usr

RUN apt-get update && \
    apt-get install -y ${BUILD_DEPS} && \
    pip install faust[fast,rocksdb] && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    apt-get purge -y --auto-remove ${BUILD_DEPS}
