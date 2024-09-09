# !/bin/bash

set -x
set -e

NO_BUILD=false
if [ "$1" = "--only-patch" ] ; then
  NO_BUILD=true
fi

source build_versions.sh

rm -rf vault vw oidc_button_web_vault.tar.gz oidc_override_web_vault.tar.gz
mkdir -p vault vw
rm -f

# Fetch default web app
git clone --depth 1  --branch "$VAULT_VERSION"  https://github.com/bitwarden/clients.git vault

# Fetch vault warden
git clone --depth 1  --branch "$VW_VERSION"  https://github.com/dani-garcia/bw_web_builds.git vw

# Copy VW ressources
cp -vf vw/resources/src/favicon.ico vault/apps/web/src/favicon.ico
cp -rvf vw/resources/src/images vault/apps/web/src/

# Apply VW patch
cd vault
git apply "../vw/patches/${PATCH_NAME}.patch"

# Prepare build
if [ "$NO_BUILD" = false ] ; then
	npm ci
	npm audit fix || true
fi

# Apply sso login button and org invite patch
git apply ../oidc_button.patch
git apply ../oidc_invite.patch
git apply ../oidc_subpath.patch

if [ "$NO_BUILD" = false ] ; then
	cd apps/web
	npm run dist:oss:selfhost
	printf '{"version": "oidc_button-%s"}' $TAG_CURRENT > build/vw-version.json
	mv build web-vault
	tar -czvf ../../../"oidc_button_web_vault.tar.gz" web-vault --owner=0 --group=0
	rm -rf web-vault
	cd ../..
fi

# Apply the override and messages patches
git apply ../oidc_override.patch
git apply ../oidc_sso_errors.patch
git apply ../oidc_messages.patch
git apply ../oidc_confirm_error.patch

if [ "$NO_BUILD" = false ] ; then
	cd apps/web
	npm run dist:oss:selfhost
	printf '{"version": "oidc_override-%s"}' $TAG_CURRENT > build/vw-version.json
	mv build web-vault
	tar -czvf ../../../"oidc_override_web_vault.tar.gz" web-vault --owner=0 --group=0
	rm -rf web-vault
	cd ../..
fi

cd ..
rm -rf vault vw
