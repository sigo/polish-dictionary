#!/usr/bin/env sh

# Load utils
. "$(dirname $0)/utils.sh"

# TODO: Think about git lfs

DATE=$(date -uR)
NUMBER_OF_WORDS=$(count_lines "${DICTIONARY}")

# Is there any changes (dictionary have changes)?
if [ -n "$(git diff)" ]; then
    README_TEMPLATE="./templates/README.md"
    README="README.md"
    ENC_SSH_KEY="./id_rsa.enc"
    REPO_URL="git@github.com:sigo/polish-dictionary.git"

    print_text "Generating readme file"
    cat "${README_TEMPLATE}" | \
        sed "s/\$CREATE_DATE/${DATE}/" | \
        sed "s/\$WORDS/${NUMBER_OF_WORDS}/" \
        > "${README}"

    print_text "Pushing updates to repository"

    # Start SSH agent
    eval `ssh-agent -s`

    # Decrypt SSH key for deployment to GitHub and add it to agent
    openssl aes-256-cbc \
        -K "${encrypted_4abc9283474e_key}" \
        -iv "${encrypted_4abc9283474e_iv}" \
        -in "${ENC_SSH_KEY}" -d | \
        ssh-add -

    # Change origin's URL to ssh-authenticated (initial clone is https)
    git remote set-url origin "${REPO_URL}"

    # Checkout to parent of detached branch
    git checkout -

    # Add files as tracked
    git add .

    # Commit changes
    git commit -m "Update [skip ci]"

    # Push changes
    git push
else
    print_text "Everything is up-to-date"
fi
