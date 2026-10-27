#!/bin/bash

# This script checks if the Dockerfile defines a non-root USER.
# It exits with an error if the USER is not set, is root, or is 0.

set -euo pipefail

DOCKERFILE_PATH="rhino-horn/Dockerfile"

# 1. Check if any USER directive exists at all
if ! grep -E -q -i '^[[:space:]]*USER[[:space:]]+' "$DOCKERFILE_PATH"; then
  echo "Error: Dockerfile does not define a USER directive. Container will run as root."
  exit 1
fi

# 2. Extract the last USER directive in the file (handles multi-stage builds correctly)
LAST_USER=$(grep -E -i '^[[:space:]]*USER[[:space:]]+' "$DOCKERFILE_PATH" | tail -n 1 | awk '{print $2}')

# 3. Validate that the user is not root or UID 0
if [[ "$LAST_USER" == "root" ]] || [[ "$LAST_USER" == "0" ]]; then
  echo "Error: Dockerfile explicitly sets USER to '$LAST_USER'. This violates security standards."
  exit 1
else 
  echo "Success: Dockerfile defines a secure non-root user setup ('USER $LAST_USER')."
fi
