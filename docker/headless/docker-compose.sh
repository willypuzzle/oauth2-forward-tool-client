#!/bin/bash
SCRIPT_DIR=$(dirname "$0")

while IFS= read -r line
do
    IFS='=' read -ra data <<< "$line"
    # shellcheck disable=SC2046
    export "${data[0]}"=$(echo -en "${data[1]}" | tr -d '\r')
done < "$SCRIPT_DIR/../.node_configuration.env"

# Check if a parameter was provided
if [ -z "$1" ]; then
    echo "No parameter provided. Please provide a parameter."
    exit 1
fi

# Validate the value of the parameter
case $1 in
    up|down|build)
        echo "First parameter is valid: $1"
        ACTION="$1"
        ;;
    *)
        echo "Invalid parameter. Please provide a valid parameter (up, down, or build)."
        exit 1
        ;;
esac

OPTION=""

if [ -n "$2" ]; then
    case $2 in
        -d|--no-cache)
            echo "Second parameter is valid: $2"
            OPTION="$2"
            ;;
        *)
            echo "Invalid parameter. Please provide a valid parameter (-d, or --no-cache)."
            exit 1
            ;;
    esac
fi

COMMAND="docker-compose -f \"$SCRIPT_DIR/docker-compose.yml\" $ACTION $OPTION"

eval $COMMAND
