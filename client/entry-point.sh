#!/bin/bash

function has_space {
    pattern=" "

    if [[ $1 =~ $pattern ]]; then
        return 0
    else
        return 1
    fi
}

function parse_variable {
  variable=$1
  if has_space "$variable"; then
    echo "\"$variable\""
  else
    echo "$variable"
  fi
}

function test_app {
    npm run build && \
    npm run start && \
    npm jest && \
    npm run cypress:headless -- --component && \
    npm run cypress:headless -- --e2e
}

SCRIPT_DIR=$(dirname "$0")

ENV_LOCAL_FILE="$SCRIPT_DIR/.env.local"

rm -f "$ENV_LOCAL_FILE"
touch "$ENV_LOCAL_FILE"

BACKEND_HOST=$(parse_variable "$BACKEND_HOST")
BACKEND_PORT=$(parse_variable "$BACKEND_PORT")
BACKEND_PROTOCOL=$(parse_variable "$BACKEND_PROTOCOL")
BACKEND_BASE_URI=$(parse_variable "$BACKEND_BASE_URI")
ENVIRONMENT=$(parse_variable "$ENVIRONMENT")

{
  echo "BACKEND_HOST=${BACKEND_HOST}"
  echo "BACKEND_PORT=${BACKEND_PORT}"
  echo "BACKEND_PROTOCOL=${BACKEND_PROTOCOL}"
  echo "BACKEND_BASE_URI=${BACKEND_BASE_URI}"
  echo "ENVIRONMENT=${ENVIRONMENT}"
} >> "$ENV_LOCAL_FILE"

if [ -n "$1" ]; then
    case $1 in
        -p|--production)
            node server.js
            ;;
        -t|--test)
            test_app
            ;;
        -d|--develop)
            npm install && npm run dev
            ;;
    esac
fi