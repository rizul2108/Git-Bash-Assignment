#!/bin/bash
# function check{
#   if()
# }

echo "Enter your Github Username"
read -r USERNAME
echo "Enter your Personal Access Token(To get this token go to GitHub and copy paste it from there)"
read -r TOKEN

# Set the repository name and description
echo "Enter the new repository name"
read -r REPO_NAME
# check "$REPO_NAME"
echo "Enter the repo's description"
read -r REPO_DESCRIPTION
echo "Enter the first commit message"
read -r COMMIT_MESSAGE
# Create the repository using cURL
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"$REPO_NAME\",\"description\":\"$REPO_DESCRIPTION\",\"private\":false}"


# Check the response status
RESPONSE_CODE=$?
if [ $RESPONSE_CODE -eq 0 ]; then
  echo "Repository created successfully!"
  echo "If you want to create a new directory for this repo then press 1 or if you want to add the current directory to repo then press 2"
  read -r INPUT
  if [ "$INPUT" -eq 1 ]
  then 
    mkdir "$REPO_NAME"
    cd "$REPO_NAME"
    echo "Enter the first file's name of this repo"
    read -r FILE_NAME
    echo "Enter the file's content"
    read -r FILE_CONTENT

    API_COMMITS_URL="https://api.github.com/repos/$USERNAME/$REPO_NAME/contents/$FILE_NAME"
    # Create the file with initial content using cURL
    curl -u "$USERNAME:$TOKEN" -X PUT -H "Accept: application/vnd.github+json" "$API_COMMITS_URL" -d "{\"message\":\"$COMMIT_MESSAGE\",\"content\":\"$(echo -n $FILE_CONTENT | base64)\",\"branch\":\"main\"}"

  elif [ "$INPUT" -eq 2 ]
      git add .
      git commit -m "$COMMIT_MESSAGE" -S
      git push -u origin main
  fi
  
  # Check the response status
  RESPONSE_CODE=$?
  if [ $RESPONSE_CODE -eq 0 ]; then
    echo "First commit created successfully!"
  else
    echo "Failed to add first commit. Please check your credentials and try again."
  fi
else
  echo "Failed to create repository. Please check your credentials and try again."
fi

