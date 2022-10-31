FROM alpine:3

RUN apk add --no-cache bash

COPY delete-old-draft-releases.sh /delete-old-draft-releases.sh

ENTRYPOINT ["/delete-old-draft-releases.sh"]
