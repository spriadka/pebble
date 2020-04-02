FROM golang:1.12-alpine

RUN apk --update upgrade \
&& apk --no-cache --no-progress add git bash curl \
&& rm -rf /var/cache/apk/*

ENV CGO_ENABLED=0 GOFLAGS=-mod=vendor

WORKDIR /pebble-src
COPY . .

RUN go install -v ./cmd/pebble/...

RUN apk update && apk add --no-cache --virtual ca-certificates

CMD [ "/go/bin/pebble" ]

EXPOSE 14000
EXPOSE 15000
