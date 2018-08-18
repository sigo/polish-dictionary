#!/usr/bin/env sh

URL="https://sjp.pl/"
DICTIONARIES_LIST_URL="${URL}slownik/en/"
RESULT_FILE="${RESULT_DIR}/pl.txt" # RESULT_DIR is environment variable, e.g. set by CI

# TODO: Check availability `RESULT_DIR` variable

print_text() {
    echo
    echo "# ${1}"
}

print_text "Downloading list of dictionaries"
DICTIONARY_PATH=$(wget -qO - "${DICTIONARIES_LIST_URL}" | sed -n 's/^.*"\/\(.*sjp-aspell6.*\.tar\.bz2\)".*$/\1/p')
DICTIONARY_URL="${URL}${DICTIONARY_PATH}"

DICTIONARY_FILENAME=$(echo "${DICTIONARY_PATH}" | sed -n 's/^.*\(sjp-aspell6.*\.tar\.bz2\)$/\1/p')
DICTIONARY_NAME=$(echo "${DICTIONARY_FILENAME}" | sed -n 's/^sjp-\(.*\)\.tar\.bz2$/\1/p')

print_text "Downloading dictionary file"
wget -qO "${DICTIONARY_FILENAME}" "${DICTIONARY_URL}"

print_text "Extracting dictionary file"
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
    sort > "${RESULT_FILE}"

# TODO: Check file exists
# TODO: Check possibility damage dictionary

NUMBER_OF_WORDS=$(wc -l "${RESULT_FILE}" | cut -d' ' -f1)
print_text "Generated dictionary have ${NUMBER_OF_WORDS} words"
