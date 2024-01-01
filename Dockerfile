FROM alpine:latest as builder

WORKDIR /src/vector
COPY . .

#RUN <<EOF
RUN apk add curl
RUN apk add gcc
RUN apk add libc-dev
RUN apk add make
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
#RUN source ~/.cargo/env && make release
RUN source ~/.cargo/env && cargo build --release
#EOF

FROM alpine:latest
WORKDIR /src/vector
COPY --from=builder /src/vector/target/release/vector ./vector
CMD ["./vector"]





