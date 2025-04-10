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
git clone --depth 1  --branch "$TAG_CURRENT"  https://github.com/timshel/bitwarden_clients.git vault
cd vault

# Prepare build
if [ "$NO_BUILD" = false ] ; then
	npm ci
	npm audit fix || true
fi

if [ "$NO_BUILD" = false ] ; then
	cd apps/web
	npm run dist:oss:selfhost
	printf '{"version": "oidc_button-%s"}' $TAG_CURRENT > build/vw-version.json
	mv build web-vault
	tar -czvf ../../../"oidc_button_web_vault.tar.gz" web-vault --owner=0 --group=0
	rm -rf web-vault
	cd ../..
fi

# Apply the override patch
git apply ../oidc_override.patch

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
