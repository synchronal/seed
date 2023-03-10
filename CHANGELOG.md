# Changelog

## Unreleased changes

- Added medic:
  - `mix archive.install hex gen_medic`
  - `mix gen.medic`
- Added db scripts in `bin/dev/db-*`
- Added `credo`, `dialyxir`, `mix_audit`, `mix_test_interactive`, `moar`, `pages`, `schema_assertions`
- Added `.envrc` and `.local/`
- Added `.tool-versions`
- Added `.formatter.exs`
- Cleaned up `mix.exs`
- `dev.exs` and `test.exs` try to get the postgres port from `PGPORT` env var
- Renamed `Seed` and `SeedWeb` modules to `Core` and `Web`
- Added `bin/dev/deps`

## v0.1.0

- Generated new Phoenix project with `phx_new 1.7.1`
  - `mix archive.install hex phx_new`
  - `mix phx.new seed --module Core --binary-id`
