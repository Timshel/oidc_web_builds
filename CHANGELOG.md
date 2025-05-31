# Changelog

## v2025.5.1-2

- Toggle the visibility of login fields.

## v2025.5.1-1

- Use Vaultwarden patched [v2025.5.1](https://github.com/vaultwarden/vw_web_builds/tree/v2025.5.1) web vault as base.

## v2025.4.1-1

- Use Vaultwarden patched [v2025.4.1](https://github.com/vaultwarden/vw_web_builds/tree/v2025.4.1) web vault as base.

## v2025.3.1-2

- Fallback to a dummy `identifier` value to ensure to skip the SSO screen

## v2025.3.1-1

- Use Vaultwarden patched [v2025.3.1](https://github.com/vaultwarden/vw_web_builds/tree/v2025.3.1) web vault as base.

## v2025.1.1-5

- During enrollment override the `idendifier` with the one returned by `auto-enroll-status` (old component).

## v2025.1.1-4

- During enrollment override the `idendifier` with the one returned by `auto-enroll-status`.

## v2025.1.1-3

- Remove the `oidc_invite` patch

## v2025.1.1-2

- On redirection keep only the base path.

## v2025.1.1-1

- Upgrade to `v2025.1.1`

## v2025.1.0-1

- Upgrade to `v2025.1.0`

## v2024.12.0-3

- Add patch to allow to hide Master password login

## v2024.12.0-2

- Fix missing logo patch

## v2024.12.0-1

- Upgrade to `v2024.12.0`

## v2024.6.2d-rc2

- Apply the sso errors patch in the `button` distribution.

## v2024.6.2d-rc1

- Upgrade to `BlackDex/bw_web_builds` to test dynamic CSS

## v2024.6.2-4

- Add an error message when trying to confirm a user with no public key

## v2024.6.2-3

- Upgrade to `v2024.6.2c`

## v2024.6.2-2

- New Org invite patch needed for invitation to survive SSO account creation

## v2024.6.2-1

- Upgrade to `v2024.6.2b`
- Org invite patch is not longer necessary

## v2024.5.1-3

- Upgrade to `v2024.5.1b`

## v2024.5.1-2

- Fix SSO redirection when using subpath

## v2024.5.1-1

- Upgrade to `v2024.5.1`

## v2024.5.0-1

- Upgrade to `v2024.5.0`

## v2024.3.1-1

- Upgrade to `v2024.3.1`

## v2024.3.1-1

- Upgrade to `v2024.3.1`

## v2024.3.0-1

- Upgrade to `v2024.3.0`

## v2024.2.5-rc

- Update to VW [pull/157/head](https://github.com/dani-garcia/bw_web_builds/pull/157)
- Experimental: fix current password check when changing password

## v2024.1.2-6

- Update to VW `v2024.1.2b`

## v2024.1.2-5

- Set the tag as the version in `vw-version.json`

## v2024.1.2-4

- Apply the [oidc_invite.patch](oidc_invite.patch) to `button` since it's expected to be merged.

## v2024.1.2-3

- Fix oversized `experimental` release

## v2024.1.2-2

- Add experimental feature to never send Master Password hash to server

## v2024.1.2-1

- Upgrade to `v2024.1.2`

## v2024.1.1-1

- Upgrade to `v2024.1.1`

## v2024.1.0-1

- Upgrade to `v2024.1.0`

## v2023.10.0-2

- Fix `vw-version.json`

## v2023.10.0-1

- Add a patch to display sso errors and redirect to the start of the flow.

## v2023.10.0

- Upgrade to `v2023.10.0`

## v2023.9.1

- Upgrade to `v2023.9.1`

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
