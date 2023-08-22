# !/bin/bash

set -x
set -e

# Commit to fetch
VAULT_VERSION=42cbdbd25284460c2d9f02e3bdd8df962080b4d2
VW_VERSION=a9d33740a03a97db57bbbe1caf0809b2b4108da2

# VaultWarden patch to apply
PATCH_NAME=v2023.7.1

rm -rf vault vw
mkdir -p vault vw

# Fetch default web app
cd vault
git init
git remote add origin https://github.com/bitwarden/clients.git
git fetch --depth 1 origin "${VAULT_VERSION}"
git -c advice.detachedHead=false checkout FETCH_HEAD
cd -

# Fetch vault warden
cd vw
git init
git remote add origin https://github.com/dani-garcia/bw_web_builds.git
git fetch --depth 1 origin "${VW_VERSION}"
git -c advice.detachedHead=false checkout FETCH_HEAD
cd -

# Copy VW ressources
cp -vf vw/resources/src/favicon.ico vault/apps/web/src/favicon.ico
cp -rvf vw/resources/src/images vault/apps/web/src/

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
