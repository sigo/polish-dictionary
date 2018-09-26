#!/usr/bin/env sh

[ -z "${DOCKER_IMAGE}" ] && print_error "DOCKER_IMAGE variable is not set"

docker build -t "${DOCKER_IMAGE}" .
