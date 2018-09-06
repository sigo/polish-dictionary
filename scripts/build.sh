#!/usr/bin/env sh

# Load utils
. "$(dirname $0)/utils.sh"

URL="https://sjp.pl/"
DICTIONARIES_LIST_URL="${URL}slownik/en/"
RESULT_FILE="${RESULT_DIR}/${RESULT_DICTIONARY}"
MIN_WORDS=4000000 # Dictionary must have greater or equal than MIN_WORDS words
MAX_WORDS=4500000 # Dictionary must have less or equal than MAX_WORDS words

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

NUMBER_OF_WORDS=$(count_lines "${RESULT_FILE}")

if [ "${NUMBER_OF_WORDS}" -lt "${MIN_WORDS}" ] || [ "${NUMBER_OF_WORDS}" -gt "${MAX_WORDS}" ]; then
    print_error "Dictionary is damaged"
fi

print_text "Dictionary is done and have ${NUMBER_OF_WORDS} words"
