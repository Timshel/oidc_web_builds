# Web Vault OIDC builds for Vaultwarden

**This project is not associated with the [Bitwarden](https://bitwarden.com/) project nor Bitwarden, Inc.**

---

<br>

This is a repository to store custom builds of the [Bitwarden web vault](https://github.com/bitwarden/clients/tree/master/apps/web) patched to work with [vaultwarden](https://github.com/dani-garcia/vaultwarden) and patched again to obtain a cleaner flow when using an SSO.

This generate three different versions :

- `button` closest to what is expected to be merge into [bw_web_builds](https://github.com/dani-garcia/bw_web_builds))
	- restore the SSO login button ([patch](oidc_button.patch)) (
	- allow organization invitation to survive sso account creation ([patch](oidc_invite.patch))
- `override` add additionally :
	- set `#sso` as the default redirect url
	- remove some unnecessary logic ([patch](oidc_override.patch))
	- display SSO errors and redirect to start of the flow ([patch](oidc_sso_errors.patch))
- `experimental` which stop sending the Master password hash to the server ([patch](oidc_experimental.patch))

## Building the web-vault
To build the web-vault you need node and npm installed.

### Using node 16 and npm
For a quick and easy local build you can run:
```bash
./build_webvault.sh
```

This will :
	
- Clone a specific version of the [Bitwarden web vault](https://github.com/bitwarden/clients/tree/master/apps/web)
- Clone a specific version of the [VaultWarden web vault builds](https://github.com/dani-garcia/bw_web_builds)
- Copy ressources from the VaultWarden web vault project
- Apply the VaultWarden web vault patch
- Apply the button [patch](oidc_button.patch)
- Apply the invite [patch](oidc_invite.patch)
- Build the web vault application
- Package it as `oidc_button_web_vault.tar.gz`.
- Apply the override [patch](oidc_override.patch) to improve SSO flow
- Apply the override [patch](oidc_sso_errors.patch) to improve SSO errors handling
- Apply the messages [patch](oidc_messages.patch)
- Build the web vault application
- Package it as `oidc_override_web_vault.tar.gz`.
- Apply the experimental [patch](oidc_experimental.patch) to improve SSO errors handling
- Build the web vault application
- Package it as `oidc_experimental_web_vault.tar.gz`.

### More information
For more information see: [Install the web-vault](https://github.com/dani-garcia/vaultwarden/wiki/Building-binary#install-the-web-vault)

### Pre-build
The builds are available in the [releases page](https://github.com/Timshel/oidc_web_builds/releases), and can be replicated with the scripts in this repo.
