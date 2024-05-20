# !/bin/bash

set -e

# Contain only the tag when it point to the commit
TAG_CURRENT=$(git describe --tags HEAD)

# Commit to fetch
VAULT_VERSION=web-v2024.5.0
VW_VERSION=v2024.5.0

# VaultWarden patch to apply
PATCH_NAME="$VW_VERSION"
