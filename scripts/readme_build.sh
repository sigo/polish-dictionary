#!/usr/bin/env sh

# Readme builder based on file template

# Load utils
. "$(dirname $0)/utils.sh"

[[ -z "${DICTIONARY}" ]] && print_error "DICTIONARY variable is empty"
[[ ! -f "${DICTIONARY}" ]] && print_error "file defined in DICTIONARY doesn't exist"

DATE=$(date -uR) # Current date in RFC 2822 format
NUMBER_OF_WORDS=$(count_lines "${DICTIONARY}") # Number of words dumped dictionary
README_TEMPLATE="$(dirname $0)/../templates/README.md" # Readme template
README="$(dirname $0)/../README.md" # Destination readme file

[[ ! -f "${README_TEMPLATE}" ]] && print_error "file defined in README_TEMPLATE doesn't exist"

print_text "Generating readme file"
cat "${README_TEMPLATE}" | \
    sed "s/\$CREATE_DATE/${DATE}/" | \
    sed "s/\$WORDS/${NUMBER_OF_WORDS}/" \
    > "${README}"
