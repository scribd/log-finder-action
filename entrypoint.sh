#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

CONTENT="${1}"
CONTENT_PATH="${2}"
SUFFIX=`echo "${3}" | tr " " "|"`

if [ -n "$CONTENT_PATH" ]; then
    # load the contents of each passed in file to $CONTENT
    while IFS= read -r line; do
        CONTENT="$CONTENT
        `cat $line || true`"
    done <<< "$CONTENT_PATH"
fi

# find all file paths of expected type inside $CONTENT string 
MATCHING_FILES=`echo $CONTENT | grep -Eo "[^ ]*\.(${SUFFIX})\b"` || true

if [ -n "$MATCHING_FILES" ]; then
    # escape special characters
    # https://github.community/t/set-output-truncates-multiline-strings/16852/3
    MATCHING_FILES="${MATCHING_FILES//'%'/'%25'}"
    MATCHING_FILES="${MATCHING_FILES//$'\n'/'%0A'}"
    MATCHING_FILES="${MATCHING_FILES//$'\r'/'%0D'}"

    echo "::set-output name=log_files::$MATCHING_FILES"
fi
