ARG NODE_VERSION
ARG ALPINE_VERSION

FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION} AS runner

RUN apk update && apk upgrade && \
    apk add --no-cache bash

RUN mkdir /code

WORKDIR /code

EXPOSE 3000

USER node

CMD ["bash", "-c", "./entry-point.sh --develop"]
