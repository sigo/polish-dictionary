#!/usr/bin/env sh

# Run docker container

# Load utils
. "$(dirname $0)/utils.sh"

[[ -z "${DOCKER_IMAGE}" ]] && print_error "DOCKER_IMAGE variable is empty"
[[ -z "${DICTIONARY}" ]] && print_error "DICTIONARY variable is empty"

# Relative path to parent directory of dictionary file
MAPPED_DIR="$(dirname ${DICTIONARY})"

docker run --rm -e DICTIONARY -v "$(pwd)/${MAPPED_DIR}:/code/${MAPPED_DIR}" "${DOCKER_IMAGE}"
