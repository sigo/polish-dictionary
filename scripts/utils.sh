#!/usr/bin/env sh

GREEN_BOLD="\e[1;32m"
RED_BOLD="\e[1;31m"
RESET_COLORS="\e[0m"

print_text() {
    echo
    echo -e "${GREEN_BOLD}${1}${RESET_COLORS}"
}

print_error() {
    echo -e "${RED_BOLD}${1}${RESET_COLORS}"
    exit 1
}
