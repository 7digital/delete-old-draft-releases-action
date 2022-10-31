FROM alpine:3

RUN apk add --no-cache bash curl jq

COPY delete-old-draft-releases.sh /delete-old-draft-releases.sh

ENTRYPOINT ["/delete-old-draft-releases.sh"]
