FROM ubuntu:jammy AS builder
RUN apt-get update && apt-get install -y curl wget build-essential pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup toolchain install nightly
RUN USER=root cargo new dezoomify-rs
ADD "https://github.com/lovasoa/dezoomify-rs/archive/refs/tags/v2.9.4.tar.gz" /dezoomify-rs-linux.tgz
RUN tar xzvf dezoomify-rs-linux.tgz
WORKDIR /dezoomify-rs-2.9.4
RUN cargo +nightly build --release -Z sparse-registry
RUN mv -v target/release/dezoomify-rs /usr/local/bin/

FROM ubuntu:jammy
RUN apt-get update && apt-get install -y wget libssl-dev && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/bin/dezoomify-rs /usr/local/bin/dezoomify-rs
ADD ./bl-dl.sh /usr/local/bin/bl-dl
VOLUME /data
WORKDIR /data
ENTRYPOINT ["bl-dl"]
