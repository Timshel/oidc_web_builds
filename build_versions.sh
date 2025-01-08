# !/bin/bash

set -e

# Contain only the tag when it point to the commit
TAG_CURRENT=$(git describe --tags HEAD)

# Commit to fetch
VAULT_VERSION=web-v2025.1.0
VW_VERSION=v2025.1.0

# VaultWarden patch to apply
PATCH_NAME="$VW_VERSION"
#PATCH_NAME="v2024.12.0"
