FROM alpine:latest as builder

WORKDIR /src/vector
COPY . .

RUN <<EOF
  apk add curl
  apk add gcc
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source ~/.cargo/env
  cargo build --release
EOF

FROM alpine:latest
WORKDIR /src/vector
COPY --from=builder /src/vector/target/release/vector ./vector
CMD ["./vector"]





