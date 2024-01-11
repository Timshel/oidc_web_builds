# !/bin/bash

set -e

SHORT_COMMIT_HASH=$(git rev-parse --short HEAD)

# Commit to fetch
VAULT_VERSION=web-v2024.1.0
VW_VERSION=v2024.1.0

# VaultWarden patch to apply
PATCH_NAME="$VW_VERSION"
