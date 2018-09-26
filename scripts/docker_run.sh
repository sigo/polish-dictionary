#!/usr/bin/env sh

[ -z "${DOCKER_IMAGE}" ] && print_error "DOCKER_IMAGE variable is not set"

MAPPED_DIR=$(dirname "${DICTIONARY}")

docker run -e DICTIONARY -v "$(pwd)/${MAPPED_DIR}:/code/${MAPPED_DIR}" "${DOCKER_IMAGE}"
