#!/usr/bin/env sh

URL="https://sjp.pl/"
DICTIONARIES_LIST_URL="${URL}slownik/en/"
RESULT_FILE="pl.txt"

echo
echo "Downloading list of dictionaries"
DICTIONARY_PATH=$(wget -qO - "${DICTIONARIES_LIST_URL}" | sed -n 's/^.*"\/\(.*sjp-aspell6.*\.tar\.bz2\)".*$/\1/p')
DICTIONARY_URL="${URL}${DICTIONARY_PATH}"

DICTIONARY_FILENAME=$(echo "${DICTIONARY_PATH}" | sed -n 's/^.*\(sjp-aspell6.*\.tar\.bz2\)$/\1/p')
DICTIONARY_NAME=$(echo "${DICTIONARY_FILENAME}" | sed -n 's/^sjp-\(.*\)\.tar\.bz2$/\1/p')

echo
echo "Downloading dictionary file"
wget -qO "${DICTIONARY_FILENAME}" "${DICTIONARY_URL}"

echo
echo "Extracting dictionary file"
tar xvjf "${DICTIONARY_FILENAME}"

echo
echo "Installing dictionary"
cd "${DICTIONARY_NAME}"
./configure
make
make install
cd ..

echo
echo "Dumping dictionary to file"
aspell -d pl dump master | \
    aspell -l pl expand | \
    sed 's/\s\s*/\n/g' | \
    sort | \
    uniq | \
    sort > "${RESULT_FILE}"

NUMBER_OF_WORDS=$(wc -l "${RESULT_FILE}" | cut -d' ' -f1)
echo
echo "Generated dictionary have ${NUMBER_OF_WORDS} words"
