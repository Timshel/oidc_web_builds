# !/bin/bash

set -x
set -e

SHORT_COMMIT_HASH=$(git rev-parse --short HEAD)

# Commit to fetch
VAULT_VERSION=42cbdbd25284460c2d9f02e3bdd8df962080b4d2
VW_VERSION=a9d33740a03a97db57bbbe1caf0809b2b4108da2

# VaultWarden patch to apply
PATCH_NAME=v2023.7.1

rm -rf vault vw
mkdir -p vault vw
rm -f oidc_button_web_vault.tar.gz oidc_override_web_vault.tar.gz

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

# Apply VW patch
cd vault
git apply "../vw/patches/${PATCH_NAME}.patch"

# Prepare build
npm ci
npm audit fix || true

# Apply sso login button patch
git apply ../oidc_button.patch

cd apps/web
npm run dist:oss:selfhost
printf '{"version": "oidc_button-%s"}' $SHORT_COMMIT_HASH \ > build/vw-version.json
mv build web-vault
tar -czvf ../../../"oidc_button_web_vault.tar.gz" web-vault --owner=0 --group=0
rm -rf web-vault
cd ../..

# Apply the full override patch
git apply ../oidc_override.patch

cd apps/web
npm run dist:oss:selfhost
printf '{"version": "oidc_override-%s"}' $SHORT_COMMIT_HASH \ > build/vw-version.json
mv build web-vault
tar -czvf ../../../"oidc_override_web_vault.tar.gz" web-vault --owner=0 --group=0

cd ../../../
rm -rf vault vw
