#!/bin/bash

if which gpg >/dev/null
then 
    echo "GPG is installed"
else 
 echo "GPG is not installed. First install GPG then try again."
    exit 1
fi

if which git >/dev/null
then 
    echo "Git is Installed"
else 
 echo "Git is not installed. First install Git then try again."
    exit 1
fi

if ! gpg --list-secret-keys --keyid-format=long | grep -q "sec"
then
  echo "No GPG key found. Generating a new key..."
  gpg --full-generate-key
else 
    echo "If you want to use an existing key, please enter 1. If you want to create a new key, please enter 2.and if want to delete a key from computer enter 3"
    read -r input
    if [ "$input" -eq 1 ]; then
        echo "Using an existing key..."
    elif [ "$input" -eq 2 ]; then
        echo "Generating a new key..."
        gpg --full-generate-key
    elif [ "$input" -eq 3 ]; then
        gpg --list-secret-keys --keyid-format=long
        echo "Enter the key ID of the key to be deleted"
        read -r key_ID
        gpg --delete-secret-key "$key_ID"
        gpg --delete-key "$key_ID"
        exit 0
    else
        echo "Invalid input. Exiting..."
        exit 1
    fi
fi

count=$(gpg --list-keys | grep -c "^pub")

if [ "$count" -gt 2 ]; then
    gpg --list-secret-keys --keyid-format=long
    echo "Enter the Key ID you want to use for git signing:"
    read -r GPG_KEY_ID
    git config --global user.signingkey "$GPG_KEY_ID"
    git config --global commit.gpgsign true
    gpg --armor --export "$GPG_KEY_ID" > public_key.asc
    cat public_key.asc
    echo "Copy this public key and paste it into a new GPG key in your GitHub account."
else
    GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | cut -d'/' -f2)
    git config --global user.signingkey "$GPG_KEY_ID"
    git config --global commit.gpgsign true
    gpg --armor --export "$GPG_KEY_ID" > public_key.asc
    cat public_key.asc
    echo "Copy this public key and paste it into a new GPG key in your GitHub account."
fi
echo "GPG key setup complete."
