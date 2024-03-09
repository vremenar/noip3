FROM rust:alpine AS build

RUN wget https://dmej8g5cpdyqd.cloudfront.net/downloads/noip-duc_3.0.0.tar.gz && \
    tar xf noip-duc_3.0.0.tar.gz

WORKDIR /noip-duc_3.0.0

RUN cargo build --release

FROM alpine:latest

COPY --from=build /noip-duc_3.0.0/target/release/noip-duc /usr/local/bin

ENTRYPOINT [ "noip-duc", "--username", "${NOIP_USERNAME}", "--password", "${NOIP_PASSWORD}" ]