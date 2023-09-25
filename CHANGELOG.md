# Changelog

## v2023.8.2-3

 - Remove the version from release file name to facilitate downloading it using [latest](https://github.com/Timshel/oidc_web_builds/releases/latest/download/oidc_override_web_vault.tar.gz).

## v2023.8.2-2

 - Apply [oidc_invite.patch](oidc_invite.patch) in the override version since it's not expected to be merged in [bw_web_builds](https://github.com/dani-garcia/bw_web_builds)).

## v2023.8.2-1

 - Add [oidc_invite.patch](oidc_invite.patch) to allow orgganization invitation to persist across redirection.

## v2023.8.2

 - Create [oidc_messages.patch](oidc_messages.patch) to make [oidc_override.patch](oidc_override.patch) more lisible.
 - Switch to using tags as references

## 2023-08-28

 - Use github actions for release
 - Add version which only restore SSO button
