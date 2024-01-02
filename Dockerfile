FROM alpine:latest as builder

WORKDIR /src/vector
COPY . .

RUN <<EOF
apk add curl
apk add gcc
apk add libc-dev
apk add make
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# source ~/.cargo/env
# RUN source ~/.cargo/env && make release
source ~/.cargo/env && cargo build --release
EOF

#FROM alpine:latest
#WORKDIR /src/vector
#COPY --from=builder /src/vector/target/release/vector ./vector
#CMD ["./vector"]





