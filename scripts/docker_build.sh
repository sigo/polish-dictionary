#!/usr/bin/env sh

# Load utils
. "$(dirname $0)/utils.sh"

[ -z "${DOCKER_IMAGE}" ] && print_error "DOCKER_IMAGE variable is not set"

docker build -t "${DOCKER_IMAGE}" .
