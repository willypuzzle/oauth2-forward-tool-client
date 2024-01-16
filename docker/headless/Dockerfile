ARG NODE_VERSION
ARG ALPINE_VERSION

FROM node:${NODE_VERSION}-alpine${ALPINE_VERSION} AS runner

RUN apk update && apk upgrade
#RUN apk add shadow bash

#ARG APP_GROUP=executer
#ARG APP_GROUP_ID=1000
#ARG APP_USER=executer
#ARG APP_USER_ID=1000

WORKDIR /app

COPY ./docker/headless/scripts/loop.sh ./
#COPY ./docker/headless/scripts/add_user.sh ./

RUN ["chmod", "+x", "./loop.sh"]
#RUN ["chmod", "+x", "./add_user.sh"]

#RUN ["/add_user.sh", ${APP_USER}, ${APP_USER_ID}, ${APP_GROUP}, ${APP_GROUP_ID}]

RUN mkdir /code

WORKDIR /code

#USER ${APP_USER}

EXPOSE 3000

USER node

ENTRYPOINT ["/app/loop.sh"]

