#!/bin/bash

function push_to_git {
  git init
  git add "$1"
  git commit -m "add $1"
  git remote add origin "https://github.com/$2/$3.git"
  git push -u origin main

  RESPONSE_CODE=$?
  if [ $RESPONSE_CODE -eq 0 ]; then
    echo "First commit created successfully!"
  else
    echo "Failed to add the first commit. Please check your credentials and try again."
    exit 1
  fi
}

USERNAME=$GIT_USERNAME
TOKEN=$GITHUB_TOKEN
if [ -z "$TOKEN" ]; then
  echo "You haven't set the personal token in an environment variable. Please enter the GitHub personal token:"
  read -sr TOKEN 
  export GITHUB_TOKEN=$TOKEN
fi 

if [ -z "$USERNAME" ]; then
  echo "You haven't set the username in an environment variable. Please enter your GitHub username:"
  read -sr USERNAME 
  export GIT_USERNAME=$USERNAME
fi 

while true; do
  echo "Enter the new repository name:"
  echo -e "The repo name must satisfy these conditions: \n1) There must be no other character than alphanumeric/_/- \n2) The length of repo name must be at least 5 characters"
  read -r REPO_NAME
  
  # Regex pattern to validate repository name
  REPO_NAME_REGEX="[a-zA-Z0-9_-]{4,}$"
  API_REPO_URL="https://api.github.com/repos/$USERNAME/$REPO_NAME"
  EXISTING_REPO=$(curl -s -o /dev/null -w "%{http_code}" -u "$USERNAME:$TOKEN" -X GET "$API_REPO_URL")

  if [ "$EXISTING_REPO" = "200" ]; then
    echo "Repository already exists. Enter a different name."
    
  else
      if [[ $REPO_NAME =~ $REPO_NAME_REGEX ]]; then
        echo "Valid repository name: $REPO_NAME"
        break
      else
        echo "Invalid repository name."
      fi
  fi
done

echo "Keep this repo private/public. Enter false for public, otherwise true:"
read -r PVT
echo "Enter the repo's description:"
read -r REPO_DESCRIPTION

# Create the repository using cURL
CREATE_REPO_RESPONSE=$(curl -s -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" "https://api.github.com/user/repos" -d "{\"name\":\"$REPO_NAME\",\"description\":\"$REPO_DESCRIPTION\",\"private\":$PVT}")

# Check the response status
RESPONSE_CODE=$?
if [ $RESPONSE_CODE -eq 0 ]; then
  echo "Repository created successfully!"
  echo "If you want to create a new directory for this repo, press 1. If you want to add files from the current directory, press 2"
  read -r INPUT
  if [ "$INPUT" == "1" ]; then
    mkdir "$REPO_NAME"
    cd "$REPO_NAME"
    echo "Enter the first file's name for this repo:"
    read -r FILE_NAME
    echo "Enter the file's content:"
    read -r FILE_CONTENT
    touch "$FILE_NAME"
    echo "$FILE_CONTENT" > "$FILE_NAME"
    push_to_git "$FILE_NAME" "$USERNAME" "$REPO_NAME"
  elif [ "$INPUT" == "2" ]; then    
    while true; do
      echo "Enter the name of the file (or path of the file if it is in a subdirectory) you want to commit (or 'exit' to finish):"
      read -r FILE_NAME
      if [ "$FILE_NAME" == "exit" ]; then
        exit 0
      fi
      
      if [ -f "$FILE_NAME" ]; then
        echo "Committing file: $FILE_NAME"
        push_to_git "$FILE_NAME" "$USERNAME" "$REPO_NAME"
      else
        echo "File '$FILE_NAME' not found in the directory. Please enter a valid file name."
      fi
    done
  fi
else
  echo "Failed to create the repository. Please check your credentials and try again."
fi
