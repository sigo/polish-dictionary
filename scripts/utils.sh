#!/usr/bin/env sh

# TODO: Color messages

print_text() {
    echo
    echo "# ${1}"
}

print_error() {
    echo "${1}"
    exit 1
}
