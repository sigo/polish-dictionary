#!/usr/bin/env sh

# Load utils
. "$(dirname $0)/utils.sh"

URL="https://sjp.pl/"
DICTIONARIES_LIST_URL="${URL}slownik/en/"
RESULT_FILE="${RESULT_DIR}/${RESULT_DICTIONARY}"
MIN_WORDS=1000000 # Dictionary must have greater or equal than MIN_WORDS words, or it is damaged

[ -z "${RESULT_DIR}" ] && print_error "RESULT_DIR variable is not set"
[ ! -d "${RESULT_DIR}" ] && print_error "RESULT_DIR directory doesn't exists"
[ -z "${RESULT_DICTIONARY}" ] && print_error "RESULT_DICTIONARY variable is not set"

# TODO: Check correctness regular expressions

print_text "Downloading list of dictionaries"
DICTIONARY_PATH=$(wget -qO - "${DICTIONARIES_LIST_URL}" | sed -n 's/^.*"\/\(.*sjp-aspell6.*\.tar\.bz2\)".*$/\1/p')
DICTIONARY_URL="${URL}${DICTIONARY_PATH}"

DICTIONARY_FILENAME=$(echo "${DICTIONARY_PATH}" | sed -n 's/^.*\(sjp-aspell6.*\.tar\.bz2\)$/\1/p')
DICTIONARY_NAME=$(echo "${DICTIONARY_FILENAME}" | sed -n 's/^sjp-\(.*\)\.tar\.bz2$/\1/p')

print_text "Downloading dictionary file (${DICTIONARY_URL})"
wget -qO "${DICTIONARY_FILENAME}" "${DICTIONARY_URL}"

print_text "Extracting dictionary file (${DICTIONARY_FILENAME})"
tar xvjf "${DICTIONARY_FILENAME}"

print_text "Installing dictionary"
cd "${DICTIONARY_NAME}"
./configure
make
make install
cd ..

print_text "Dumping dictionary to file"
aspell -d pl dump master | \
    aspell -l pl expand | \
    sed 's/\s\s*/\n/g' | \
    sort | \
    uniq | \
    sort \
    > "${RESULT_FILE}"

[ ! -f "${RESULT_FILE}" ] && print_error "Dictionary file doesn't exists"

# TODO: Find proper way to count lines
NUMBER_OF_WORDS=$(wc -l "${RESULT_FILE}" | cut -d' ' -f1)

# TODO: Add MAX_WORDS condition
[ "${NUMBER_OF_WORDS}" -lt "${MIN_WORDS}" ] && print_error "Dictionary is damaged"

print_text "Dictionary is done and have ${NUMBER_OF_WORDS} words"
