#!/bin/bash

function push_to_git {
  git init
  git add .
  git commit -m "Initial Commit"
  git remote add origin "https://github.com/$1/$2.git"
  git push -u origin main

  RESPONSE_CODE=$?
  if [ $RESPONSE_CODE -eq 0 ]; then
    echo "First commit created successfully!"
  else
    echo "Failed to add first commit. Please check your credentials and try again."
    exit 1
  fi
}

USERNAME=$(git config --global github.user)
echo "Enter your Personal Access Token (To get this token, go to GitHub and copy-paste it from there)"
read -sr TOKEN

while true; do
  echo "Enter new repository name"
  read -r REPO_NAME
  
  # Regex pattern to validate repository name
  REPO_NAME_REGEX="^[A-Z][^\.]*$"
  API_REPO_URL="https://api.github.com/repos/$USERNAME/$REPO_NAME"
  EXISTING_REPO=$(curl -s -o /dev/null -w "%{http_code}" -u "$USERNAME:$TOKEN" -X GET "$API_REPO_URL")

  if [ $EXISTING_REPO -eq 200 ]; then
    echo "Repository already exists. Aborting..."
  fi
  if [[ $REPO_NAME =~ $REPO_NAME_REGEX ]]; then
    echo "Valid repository name: $REPO_NAME"
    break
  else
    echo "Invalid repository name. Repository name should not contain a dot (.) and the first letter must be capitalized."
  fi
done



echo "Enter the repo's description"
read -r REPO_DESCRIPTION

# Create the repository using cURL
CREATE_REPO_RESPONSE=$(curl -s -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/user/repos" -d "{\"name\":\"$REPO_NAME\",\"description\":\"$REPO_DESCRIPTION\",\"private\":false}")

# Check the response status
RESPONSE_CODE=$?
if [ $RESPONSE_CODE -eq 0 ]; then
  echo "Repository created successfully!"
  echo "If you want to create a new directory for this repo, press 1. If you want to add the current directory to the repo, press 2"
  read -r INPUT
  if [ "$INPUT" -eq 1 ]; then
    mkdir "$REPO_NAME"
    cd "$REPO_NAME"
    echo "Enter the first file's name of this repo"
    read -r FILE_NAME
    echo "Enter the file's content"
    read -r FILE_CONTENT
    touch "$FILE_NAME"
    echo "$FILE_CONTENT" > "$FILE_NAME"
    push_to_git "$USERNAME" "$REPO_NAME"
  elif [ "$INPUT" -eq 2 ]; then
    push_to_git "$USERNAME" "$REPO_NAME"
  fi
else
  echo "Failed to create repository. Please check your credentials and try again."
fi
