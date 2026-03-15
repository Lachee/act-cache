FROM golang:1.25 AS builder

WORKDIR /usr/src/act-cache

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -v -o /usr/local/bin/act-cache .

FROM alpine:3.23.3

COPY --from=builder /usr/local/bin/act-cache /usr/local/bin/act-cache

VOLUME ["/data"]

EXPOSE 8111

CMD ["/usr/local/bin/act-cache", "--dir", "/data", "--port", "8088"]