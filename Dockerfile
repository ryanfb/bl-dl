FROM ubuntu:jammy

RUN apt-get update && apt-get install -y curl wget build-essential pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain nightly
ENV PATH=/root/.cargo/bin:$PATH
RUN rustup toolchain install nightly
ADD "https://github.com/lovasoa/dezoomify-rs/archive/refs/tags/v2.9.4.tar.gz" /dezoomify-rs-linux.tgz
ADD ./bl-dl.sh /usr/local/bin/bl-dl
RUN tar xzvf dezoomify-rs-linux.tgz && cd /dezoomify-rs-2.9.4 && cargo +nightly build --release -Z sparse-registry && mv -v target/release/dezoomify-rs /usr/local/bin/ && cd / && rm -rf dezoomify-rs-2.9.4 dezoomify-rs-linux.tgz && chmod a+x /usr/local/bin/bl-dl && rm -rf ~/.cargo
VOLUME /data
WORKDIR /data
ENTRYPOINT ["bl-dl"]
