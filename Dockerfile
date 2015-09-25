FROM alpine

MAINTAINER Philipz <philipzheng@gmail.com>
ENV VERSION v0.5.4
RUN apk update && \
    apk add --virtual git && \
    apk add --virtual autoconf && \
    apk add --virtual build-base && \
    apk add --virtual automake && \
    apk add --virtual openssl-dev && \
    apk add --virtual libtool
RUN git clone https://github.com/Netflix/dynomite.git

WORKDIR dynomite/

RUN git checkout $VERSION
RUN autoreconf -fvi && ./configure && make

RUN sed -i 's/127.0.0.1:8/0.0.0.0:8/g' conf/dynomite.yml
RUN sed -i 's/127.0.0.1:22122/redisserver:6379/g' conf/dynomite.yml

RUN apk del --virtual git && \
    apk del --virtual autoconf && \
    apk del --virtual build-base && \
    apk del --virtual automake && \
    apk del --virtual openssl-dev && \
    apk del --virtual libtool && rm -rf /var/cache/apk/*

EXPOSE 8101 8102 22222

CMD ["src/dynomite", "--conf-file=conf/dynomite.yml", "-v11"]
