FROM alpine:3.7
LABEL maintainer="Trent Scholl <me@trentscholl.com>"

ENV GOPATH /go

RUN apk add --update --no-cache --virtual .build-deps build-base git go make && \
    go get github.com/barnybug/cli53 && \
    cd $GOPATH/src/github.com/barnybug/cli53 && \
    make install && \
    mv /go/bin/cli53 /usr/local/bin/cli53 && \
    rm -rf $GOPATH && \
    apk del .build-deps && \
    rm -rf var/cache/apk/*

COPY update-dynamic-dns.sh /update-dynamic-dns.sh

ENTRYPOINT ["/update-dynamic-dns.sh"]