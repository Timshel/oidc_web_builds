# !/bin/bash

set -x
set -e

# Commit to fetch
VAULT_VERSION=8b9bdddf812f1e443d2d1ff1d1906c396e3afbdd
VW_VERSION=cffdfb06f9e1faa29f1aec33759b18b35d63bf8a

# VaultWarden patch to apply
PATCH_NAME=v2023.1.1

rm -rf vault vw
mkdir -p vault vw

# Fetch default web app
cd vault
git init
git remote add origin https://github.com/bitwarden/clients.git
git fetch --depth 1 origin "${VAULT_VERSION}"
git -c advice.detachedHead=false checkout FETCH_HEAD
cd -

# Fetch vaul warden
cd vw
git init
git remote add origin https://github.com/dani-garcia/bw_web_builds.git
git fetch --depth 1 origin "${VW_VERSION}"
git -c advice.detachedHead=false checkout FETCH_HEAD
cd -

# Copy VW ressources
cp -vf vw/resources/favicon.ico vault/apps/web/src/favicon.ico
cp -vf vw/resources/* vault/apps/web/src/images/

# Apply the patch
cd vault
git apply "../vw/patches/${PATCH_NAME}.patch"
git apply ../oidc_override.patch

# build
# Build
npm ci
npm audit fix || true

cd apps/web
npm run dist:oss:selfhost
printf '{"version":"oidc_%s"}' $(date '+%Y-%m-%d') \ > build/vw-version.json
mv build web-vault
tar -czvf ../../../"oidc_web_vault_$(date '+%Y-%m-%d').tar.gz" web-vault --owner=0 --group=0

cd ../../../
rm -rf vault vw