#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
#set -o verbose
#set -o xtrace

function error() {
    echo "****** Failed ******" | red >&2
}
trap error ERR

function finish() {
    echo "Success" | green >&2
}
trap finish EXIT

function log() {
    echo $1 | green >&2
}

function red() {
    tput setaf 1
    cat
    tput sgr0
}

function green() {
    tput setaf 2
    cat
    tput sgr0
}

docker-compose build
docker-compose run core "" "test/test.txt test/failure.log" txt