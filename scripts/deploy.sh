#!/usr/bin/env sh

# Is there any changes (i.e. dictionary have changes)?
if [ -n "$(git diff)" ]; then
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

    # Add result directory as tracked
    git add "${RESULT_DIR}"

    # Commit changes
    git commit -m "Update"

    # Push changes
    git push
else
    echo "No changes"
fi
