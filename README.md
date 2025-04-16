# Web Vault OIDC builds for Vaultwarden

**This project is not associated with the [Bitwarden](https://bitwarden.com/) project nor Bitwarden, Inc.**

---

<br>

This is a repository to build custom versions of the [Bitwarden web vault](https://github.com/bitwarden/clients/tree/master/apps/web).
/
This rely on prepatched version from [Vaultwarden](https://github.com/vaultwarden/vw_web_builds).
/
The final patched code is available in [bitwarden_clients](https://github.com/timshel/bitwarden_clients).

This generate two different versions :

- `button` closest to what is expected to be merge into [vw_web_builds](https://github.com/vaultwarden/vw_web_builds))
- `override` add additionally :
	- set `#sso` as the default redirect url
	- remove some unnecessary logic ([patch](oidc_override.patch))

## Building the web-vault
To build the web-vault you need node and npm installed.

### Using node and npm
For a quick and easy local build you can run:
```bash
./build_webvault.sh
```

This will :
- Clone a patched version of the [Bitwarden web vault](https://github.com/timshel/bitwarden_clients)
- Build the web vault application
- Package it as `oidc_button_web_vault.tar.gz`.
- Apply the override [patch](oidc_override.patch) to improve SSO flow
- Build the web vault application
- Package it as `oidc_override_web_vault.tar.gz`.

### More information
For more information see: [Install the web-vault](https://github.com/dani-garcia/vaultwarden/wiki/Building-binary#install-the-web-vault)

### Pre-build
The builds are available in the [releases page](https://github.com/Timshel/oidc_web_builds/releases), and can be replicated with the scripts in this repo.
