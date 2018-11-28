#!/usr/bin/env sh

# Push dictionary file back to repository
# TODO: Think about git lfs

# Load utils
. "$(dirname $0)/utils.sh"

# Is there any changes (dictionary have changes)?
if [[ -n "$(git diff)" ]]; then
    ENC_SSH_KEY="./id_rsa.enc"
    REPO_URL="git@github.com:sigo/polish-dictionary.git"
    COMMIT_MESSAGE="fix(dictionary): Update dictionary"

    print_text "Pushing updates to repository"

    # Start SSH agent
    eval `ssh-agent -s &> /dev/null`

    # Decrypt SSH key for deployment to GitHub and add it to agent
    openssl aes-256-cbc \
        -K "${encrypted_4abc9283474e_key}" \
        -iv "${encrypted_4abc9283474e_iv}" \
        -in "${ENC_SSH_KEY}" -d | \
        ssh-add - \
        &> /dev/null

    # Change origin's URL to ssh-authenticated (initial clone is https)
    git remote set-url origin "${REPO_URL}"

    # Checkout to parent of detached branch
    git checkout - &> /dev/null

    # Add files as tracked
    git add .

    # Commit changes
    git commit -m "${COMMIT_MESSAGE}"

    # Push changes
    git push &> /dev/null
else
    print_text "Everything is up-to-date"
fi
