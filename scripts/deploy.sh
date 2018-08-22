#!/usr/bin/env sh

# TODO: Print messages about deploy steps
# TODO: Think about git lfs
# TODO: Think about pushing to github releases

# Is there any changes (i.e. dictionary have changes)?
if [ ! -n "$(git diff)" ]; then
    DATE=$(date)
    NUMBER_OF_WORDS=$(wc -l "./dist/pl.txt" | cut -d' ' -f2)

    wc -l "./dist/pl.txt"
    echo $NUMBER_OF_WORDS

    cat ./templates/README.md | \
        sed "s/\$CREATE_DATE/$DATE/" | \
        sed "s/\$WORDS/$NUMBER_OF_WORDS/" \
        > "README.md"

    # Start SSH agent
    eval `ssh-agent -s` \
        1> /dev/null

    # Decrypt SSH key for deployment to GitHub and add it to agent
    openssl aes-256-cbc \
        -K "${encrypted_4abc9283474e_key}" \
        -iv "${encrypted_4abc9283474e_iv}" \
        -in "${ENC_SSH_KEY}" -d | \
        ssh-add - \
        1> /dev/null

    # Change origin's URL to ssh-authenticated (initial clone is https)
    git remote set-url origin "${REPO_URL}"

    # Checkout to parent of detached branch
    git checkout - \
        1> /dev/null

    # Add files as tracked
    git add .

    # Commit changes
    git commit -m "Update" \
        1> /dev/null

    # Push changes
    git push \
        1> /dev/null
else
    echo "No changes"
fi
