#!/bin/bash

if which gpg >/dev/null; then
  echo "GPG is installed"
else
  echo "GPG is not installed. First install GPG then try again."
  exit 1
fi

if which git >/dev/null; then
  echo "Git is installed"
else
  echo "Git is not installed. First install Git then try again."
  exit 1
fi

function git_config {
  local key_id="$1"
  git config --global user.signingkey "$key_id"
  git config --global commit.gpgsign true
  gpg --armor --export "$key_id" >public_key.asc
  cat public_key.asc
  echo "Copy this public key and paste it into a new GPG key in your GitHub account."
}

if ! gpg --list-secret-keys --keyid-format=long | grep -q "sec"; then
  echo "No GPG key found. Generating a new key..."
  gpg --full-generate-key
  GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | cut -d'/' -f2 | tail -n 1)
  git_config "$GPG_KEY_ID"
else
  echo "If you want to use an existing key, please enter 1. If you want to create a new key, please enter 2, and if you want to delete a key from your computer, enter 3:"
  read -r input
  if [ "$input" -eq 1 ]; then
    echo "Using an existing key..."
  elif [ "$input" -eq 2 ]; then
    echo "Generating a new key..."
    gpg --full-generate-key
    GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | cut -d'/' -f2 | tail -n 1)
    git_config "$GPG_KEY_ID"
  elif [ "$input" -eq 3 ]; then
    gpg --list-secret-keys --keyid-format=long
    echo "Enter the key ID of the key to be deleted:"
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

if [ "$count" -gt 1 ]; then
  gpg --list-secret-keys --keyid-format=long
  echo "Enter the Key ID you want to use for Git signing:"
  read -r GPG_KEY_ID
  git_config "$GPG_KEY_ID"
else
  GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | cut -d'/' -f2)
  git_config "$GPG_KEY_ID"
fi

echo "GPG key setup complete."
