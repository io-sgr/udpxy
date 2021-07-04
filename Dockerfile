FROM alpine:latest
MAINTAINER SgrAlpha <admin@mail.sgr.io>

EXPOSE 4022
ENTRYPOINT ["/docker-entrypoint.sh"]

RUN apk --update --no-cache add curl build-base && \
    curl -Ls http://www.udpxy.com/download/udpxy/udpxy-src.tar.gz -o /tmp/udpxy-src.tar.gz && \
    gzip -dc /tmp/udpxy-src.tar.gz | tar -xvf - -C /tmp && \
    cd /tmp/udpxy-1.0.23-12 && \
    make && \
    cp /tmp/udpxy-1.0.23-12/udpxy /usr/local/bin/ && \
    apk del build-base && \
    rm -rf /tmp/* /var/cache/apk/*

COPY ./docker-entrypoint.sh /

CMD /usr/local/bin/udpxy -vT -p 4022 -c 10 -M 300
