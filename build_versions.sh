# !/bin/bash

set -e

# Contain only the tag when it point to the commit
TAG_CURRENT=$(git describe --tags HEAD)

# Commit to fetch
VAULT_VERSION=web-v2025.1.1
VW_VERSION=v2025.1.1

# VaultWarden patch to apply
PATCH_NAME="$VW_VERSION"
#PATCH_NAME="v2024.12.0"
