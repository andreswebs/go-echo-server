FROM golang:alpine as builder
RUN \
  echo "app:x:10001:10001:app:/app:/bin/false" > /app-user && \
  echo "app:x:10001:" > /app-group
RUN \
  mkdir /build
COPY src/* /build/
WORKDIR /build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags='-extldflags "-static" -s -w' -o server .

FROM scratch
COPY --from=builder /app-user /etc/passwd
COPY --from=builder /app-group /etc/group
COPY --chown=app:app --from=builder /build/server /app/
USER app
WORKDIR /app
EXPOSE 8080
CMD ["/app/server"]
