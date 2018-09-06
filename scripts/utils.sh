#!/usr/bin/env sh

GREEN_BOLD="\033[1;32m"
RED_BOLD="\033[1;31m"
RESET_COLORS="\033[0m"

print_text() {
    printf "\n${GREEN_BOLD}${1}${RESET_COLORS}\n"
}

print_error() {
    printf "${RED_BOLD}${1}${RESET_COLORS}\n"
    exit 1
}
