#!/bin/bash

# PID and GID to check
USER_NAME="$1"
PID_TO_CHECK="$2"
GROUP_NAME="$3"
GID_TO_CHECK="$4"

# Check if the group exists
if getent group "$GID_TO_CHECK" >/dev/null 2>&1; then
    echo "Group with GID $GID_TO_CHECK exists."
    CURRENT_GROUP_STRING=$(getent group "$GID_TO_CHECK")
    CURRENT_GROUP_NAME=$(echo "$CURRENT_GROUP_STRING" | cut -d':' -f1)
    groupmod -n "$GROUP_NAME" "$CURRENT_GROUP_NAME"
else
    echo "Group with GID $GID_TO_CHECK does not exist."
    addgroup -g "$GID_TO_CHECK" -S "$GROUP_NAME"
fi

# Check if the user exists
if id -u "$PID_TO_CHECK" >/dev/null 2>&1; then
    echo "User $PID_TO_CHECK exists."
    CURRENT_USER_NAME=$(getent passwd "$PID_TO_CHECK" | cut -d':' -f1)
    usermod -l "$USER_NAME" "$CURRENT_USER_NAME"
    usermod -a -G "$GROUP_NAME" "$USER_NAME"
else
    echo "User $PID_TO_CHECK does not exist."
    adduser -u "$PID_TO_CHECK" -S -D -H -G "$GROUP_NAME" "$USER_NAME"
fi

adduser "$USER_NAME" tty
