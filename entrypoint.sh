#!/usr/bin/env sh

set -o errexit
set -o nounset
set -o pipefail
#set -o verbose
#set -o xtrace

# CONTENT="${1}"
# CONTENT_PATH="${2}"
# SUFFIX="${3}"

echo "a"
env

# if [ -n "$CONTENT_PATH" ]; then
#     while IFS= read -r line; do
#         CONTENT="$CONTENT
#         `cat $line || true`"
#     done <<< "$CONTENT_PATH"
#     echo $CONTENT
# fi

# MATCHING_FILES=`echo $CONTENT | grep -Eo "[^ ]*\.${SUFFIX}\b"` || true

# if [ -n "$MATCHING_FILES" ]; then
#     # escape special characters
#     # https://github.community/t/set-output-truncates-multiline-strings/16852/3
#     MATCHING_FILES="${MATCHING_FILES//'%'/'%25'}"
#     MATCHING_FILES="${MATCHING_FILES//$'\n'/'%0A'}"
#     MATCHING_FILES="${MATCHING_FILES//$'\r'/'%0D'}"

#     echo "::set-output name=log_files::$MATCHING_FILES"
# fi
