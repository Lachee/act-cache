FROM golang:1.25-alpine3.23 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -v .

FROM alpine:3.23

COPY --from=builder --chmod=755 /app/act-cache /usr/local/bin/act-cache

VOLUME ["/data"]

ENV ACT_CACHE_PORT=8111

ENV ACT_CACHE_DIR=/data

EXPOSE $ACT_CACHE_PORT

CMD ["/usr/local/bin/act-cache"]