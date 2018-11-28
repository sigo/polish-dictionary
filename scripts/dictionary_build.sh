#!/usr/bin/env sh

# Generate polish dictionary file
#
# All process is divided as following steps
# 1. Find URL to newest polish dictionary aspell's package and download it
# 2. Import package to aspell
# 3. Dump dictionary as plain txt words list file with sorted and unique entries
# There's end test which is checking correctness of dumped dictionary
# TODO: Check correctness regular expressions

# Load utils
. "$(dirname $0)/utils.sh"

URL="https://sjp.pl/" # Domain's site URL with polish dictionary
DICTIONARIES_LIST_URL="${URL}slownik/en/" # URL page contains links to dictionary packages
MIN_WORDS=4000000 # Dictionary must have greater or equal than MIN_WORDS words
MAX_WORDS=4500000 # Dictionary must have less or equal than MAX_WORDS words

[[ -z "${DICTIONARY}" ]] && print_error "DICTIONARY variable is empty"

print_text "Downloading list of dictionaries"

# Get relative URL path of current available dictionary package archive
# tl;dr: If something will break in the future, it will notify error state in end test.
#
# This step may be confusing, because it gets path from HTML tree with regexp. This is generally discouraged way to
# solve this problem. However there's no solid HTML tree parser in bash, and script need pull simple path just one time.
# To be really proper, it should be processed by real XML/HTML tree parser, which require e.g. python or node
# environment and installing additional libraries (this will make docker image size be x2 or x3 and whole process will
# be longer for a few seconds).
DICTIONARY_PATH=$(wget -qO - "${DICTIONARIES_LIST_URL}" | sed -n 's/^.*"\/\(.*sjp-aspell6.*\.tar\.bz2\)".*$/\1/p')

# Full URL to dictionary package
DICTIONARY_URL="${URL}${DICTIONARY_PATH}"

# Filename of package
DICTIONARY_FILENAME=$(echo "${DICTIONARY_PATH}" | sed -n 's/^.*\(sjp-aspell6.*\.tar\.bz2\)$/\1/p')

# Part of file name, which is used as extracted directory name
# TODO: Find better way, this part is tricky, because it's rely on guessing name
DICTIONARY_NAME=$(echo "${DICTIONARY_FILENAME}" | sed -n 's/^sjp-\(.*\)\.tar\.bz2$/\1/p')

# Download dictionary archive
print_text "Downloading dictionary file (${DICTIONARY_URL})"
wget -qO "${DICTIONARY_FILENAME}" "${DICTIONARY_URL}"

# Extract archive
print_text "Extracting dictionary file (${DICTIONARY_FILENAME})"
tar xvjf "${DICTIONARY_FILENAME}"

# Execute dictionary install process described in internal (in dictionary archive) `README` file
print_text "Installing dictionary"
(cd "${DICTIONARY_NAME}" && ./configure && make && make install)

# Dump installed dictionary as plain txt file, sorted and without duplicated words for sure
print_text "Dumping dictionary"
aspell -d pl dump master | \
    aspell -l pl expand | \
    sed 's/\s\s*/\n/g' | \
    sort | \
    uniq | \
    sort \
    > "${DICTIONARY}"

# Number of total words in dumped dictionary
NUMBER_OF_WORDS=$(count_lines "${DICTIONARY}")

# Check does dictionary have abnormal number of words
# TODO: Move out test to separated file
if [[ "${NUMBER_OF_WORDS}" -lt "${MIN_WORDS}" ]] || [[ "${NUMBER_OF_WORDS}" -gt "${MAX_WORDS}" ]]; then
    print_error "Dictionary is most likely damaged"
fi

print_text "Dictionary is done and have ${NUMBER_OF_WORDS} words"
