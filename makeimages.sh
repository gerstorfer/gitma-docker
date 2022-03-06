docker buildx build \
       --push \
       --platform linux/arm64,linux/amd64 \
       --tag gerstorfer/gitma-demo:latest \
       .
