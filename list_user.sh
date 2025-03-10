#!/bin/bash
###############
# TO list the users in the organization using shell scripting
#
# By Shaik Ammar
# https://api.github.com/repos/OWNER/REPO/issues
###############

# GitHub API URL
API_URL="https://api.github.com"

#GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# user and repo information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a get request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"
     
      #send a GET request to the GitHub API with authentication
      curl -s -u "${USERNAME}:${TOKEN}" "$url"
} 

#function to list user with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    #Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"
 
    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No user with read access found for ${REPO_OWNER}/${REPO_NAME=}:"
    else 
        echo "User with read access to ${REPO_OWNER}/${REPO_NAME=}:"
        echo "$collaborators"
    fi
}

















 
