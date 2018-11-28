#!/usr/bin/env sh

# Build docker image with dictionary builder script

# Load utils
. "$(dirname $0)/utils.sh"

[[ -z "${DOCKER_IMAGE}" ]] && print_error "DOCKER_IMAGE variable is empty"

# Relative path to parent directory of `Dockerfile`
DOCKERFILE_DIR="$(dirname $0)/../"

docker build -t "${DOCKER_IMAGE}" "${DOCKERFILE_DIR}"
