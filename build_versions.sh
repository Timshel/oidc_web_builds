# !/bin/bash

set -e

SHORT_COMMIT_HASH=$(git rev-parse --short HEAD)

# Commit to fetch
VAULT_VERSION=web-v2024.1.1
VW_VERSION=v2024.1.1b

# VaultWarden patch to apply
# PATCH_NAME="$VW_VERSION"
PATCH_NAME="v2024.1.0"
