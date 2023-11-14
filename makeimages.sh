caffeinate -s docker buildx build \
       --push \
       --platform linux/arm64,linux/amd64 \
       --tag gerstorfer/gitma-demo:catma7 \
       --tag gerstorfer/gitma-demo:latest \
       .
