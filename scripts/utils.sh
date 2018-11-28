#!/usr/bin/env sh

# Bash utils

# Text colors values used in shells
GREEN_BOLD="\033[1;32m"
RED_BOLD="\033[1;31m"
RESET_COLORS="\033[0m"

# `printf` and text coloring is more compatible than `echo`
# In this project, there was problem between `sh` and `bash`

# Print green text with bold
# TODO: Remove initial new line
print_text() {
    printf "\n${GREEN_BOLD}${1}${RESET_COLORS}\n"
}

# Print red text with bold and return `1` exit code
print_error() {
    printf "${RED_BOLD}${1}${RESET_COLORS}\n"
    exit 1
}

# Count lines of passed input (stdin or file to path) and returns only number
# Example usage: `LINES = count_lines("file.txt")` will save number of lines in `LINES` variable
count_lines() {
    wc -l "${1}" | awk '{print $1}'
}

# Check is variable not empty
# TODO: Write function body
check_var() {
    print_error "Function is not defined yet"
}
