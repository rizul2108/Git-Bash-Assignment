#!/bin/bash

echo "Enter your Github Username"
read -r USERNAME
echo "Enter your Personal Access Token"
read -r TOKEN

# Set the repository name and description
echo "Enter the new repository name"
read -r REPO_NAME
echo "Enter the repo's description"
read -r REPO_DESCRIPTION

echo "Enter the repository's visibility private/public"
read -r REPO_VISIBILITY

echo "Enter the first file's name of this repo"
read -r FILE_NAME
echo "Enter the first commit message"
read -r COMMIT_MESSAGE
echo "Enter the file's content"
read -r FILE_CONTENT

# Set the API endpoints
API_REPOS_URL="https://api.github.com/user/repos"
API_COMMITS_URL="https://api.github.com/repos/$USERNAME/$REPO_NAME/contents/$FILE_NAME"

# Create the repository using cURL
curl -u "$USERNAME:$TOKEN" -X POST -H "Accept: application/vnd.github.v3+json" "$API_REPOS_URL" -d "{\"name\":\"$REPO_NAME\",\"description\":\"$REPO_DESCRIPTION\",\"private\":$REPO_VISIBILITY}"

# Check the response status
RESPONSE_CODE=$?
if [ $RESPONSE_CODE -eq 0 ]; then
  echo "Repository created successfully!"

  # Create the file with initial content using cURL
  curl -u "$USERNAME:$TOKEN" -X PUT -H "Accept: application/vnd.github.v3+json" "$API_COMMITS_URL" -d "{\"message\":\"$COMMIT_MESSAGE\",\"content\":\"$(echo -n $FILE_CONTENT | base64)\",\"branch\":\"main\"}"

  # Check the response status
  RESPONSE_CODE=$?
  if [ $RESPONSE_CODE -eq 0 ]; then
    echo "First commit created successfully!"
  else
    echo "Failed to create first commit. Please check your credentials and try again."
  fi
else
  echo "Failed to create repository. Please check your credentials and try again."
fi
