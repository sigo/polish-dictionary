#!/usr/bin/env sh

LIGHT_GREEN_BOLD="\e[1;92m"
LIGHT_RED_BOLD="\e[1;91m"
RESET_COLORS="\e[0m"

print_text() {
    echo
    echo "${LIGHT_GREEN_BOLD}${1}${RESET_COLORS}"
}

print_error() {
    echo "${LIGHT_RED_BOLD}${1}${RESET_COLORS}"
    exit 1
}
