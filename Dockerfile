FROM ubuntu:jammy

RUN apt-get update && apt-get install -y wget cargo build-essential pkg-config libssl-dev
ADD "https://github.com/lovasoa/dezoomify-rs/archive/refs/tags/v2.8.0.tar.gz" /dezoomify-rs-linux.tgz
ADD ./bl-dl.sh /usr/local/bin/bl-dl
RUN tar xzvf dezoomify-rs-linux.tgz && cd /dezoomify-rs-2.8.0 && cargo build --release && mv -v target/release/dezoomify-rs /usr/local/bin/ && cd / && rm -rf dezoomify-rs-2.8.9 dezoomify-rs-linux.tgz && chmod a+x /usr/local/bin/bl-dl
VOLUME /data
WORKDIR /data
ENTRYPOINT ["bl-dl"]
