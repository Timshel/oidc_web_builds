# !/bin/bash

set -x
set -e

NO_BUILD=false
if [ "$1" = "--only-patch" ] ; then
  NO_BUILD=true
fi

function replace_embedded_svg_icon() {
if [ ! -f "$1" ]; then echo "$1 does not exist"; exit 255; fi
if [ ! -f "$2" ]; then echo "$2 does not exist"; exit 255; fi

echo "'$1' -> '$2'"

first='`$'
last='^`'
sed -i "/$first/,/$last/{ /$first/{p; r $1
}; /$last/p; d }" "$2"
}

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

echo "Patching logos"
replace_embedded_svg_icon \
	vw/resources/vaultwarden-admin-console-logo.svg \
	vault/apps/web/src/app/admin-console/icons/admin-console-logo.ts
replace_embedded_svg_icon \
	vw/resources/vaultwarden-password-manager-logo.svg \
	vault/apps/web/src/app/layouts/password-manager-logo.ts
replace_embedded_svg_icon \
	vw/resources/src/images/logo.svg \
	vault/libs/auth/src/angular/icons/bitwarden-logo.icon.ts
replace_embedded_svg_icon \
	vw/resources/vaultwarden-icon.svg \
	vault/libs/auth/src/angular/icons/bitwarden-shield.icon.ts

echo "Remove non-free bitwarden_license/ code"
rm -rf vault/bitwarden_license/
if [ -d "vault/apps/web/src/app/tools/access-intelligence/" ]; then
    rm -rf vault/apps/web/src/app/tools/access-intelligence/
fi

# Apply VW patch
cd vault
git apply "../vw/patches/${PATCH_NAME}.patch"

# Prepare build
if [ "$NO_BUILD" = false ] ; then
	npm ci
	npm audit fix || true
fi

# Apply org invite and subpath patch
git apply ../oidc_subpath.patch
git apply ../oidc_sso_errors.patch
git apply ../oidc_hide_master_password_login.patch

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
