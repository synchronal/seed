# Changelog

## Unreleased changes

- Added medic:
  - `mix archive.install hex gen_medic`
  - `mix gen.medic`
- Added db scripts in `bin/dev/db-*`
- Added `credo`, `dialyxir`, and `mix_audit`
- Added `.envrc` and `.local/`
- Added `.tool-versions`
- `dev.exs` and `test.exs` try to get the postgres port from `PGPORT` env var
- Add `.formatter.exs`
- Clean up `mix.exs`

## v0.1.0

- Generated new Phoenix project with `phx_new 1.7.1`
  - `mix archive.install hex phx_new`
  - `mix phx.new seed --module Core --binary-id`
