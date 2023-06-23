# Seed

A base for a Phoenix LiveView app. To use Seed as a base for your new project, see [seed_readme.md](./seed_readme.md).
Once you create your project using Seed, delete this paragraph from the README in your repo.

## Setting up the project on a dev machine

After cloning the project, run `bin/dev/doctor` over and over until all issues are fixed.

## Day-to-day development

This project includes [Medic](https://github.com/synchronal/medic) which is a collection of development lifecycle
scripts. Medic was designed to be used with trunk-based development, where most work is done on the main branch, and
it's rare to have other branches). Trunk-based development speeds up development by removing the cascading delays
brought on by code reviews and by the conflicts and hidden code inherent with long-lived branches.

Instead of `git pull` or `git merge`, use `bin/dev/update` and instead of `git push`, use `bin/dev/shipit`.

`bin/dev/update` does the following by default:

- updates code
- updates dependencies
- compiles
- runs doctor to make sure your local dev environment is set up correctly after merging changes that might affect it
- runs migrations

`bin/dev/shipit` does the following by default:

- audits the code for proper formatting, code quality, unused dependencies, etc
- runs `bin/dev/update`
- runs tests

The typical workflow is:

- run `bin/dev/update` to pull code from origin
- run `bin/dev/start` to run the server
- write code & run tests
- commit
- run `bin/dev/shipit` to run all checks and push to origin

## Configuring deployments

This section assumes you're deploying to [Fly](https://fly.io) via GitHub actions. Otherwise you're on your own :)

Make sure you have a Fly org via `fly orgs list` and if not, create one via `fly orgs create`.

Create Fly staging and prod apps if you haven't already, replacing `<projectname>` with your project name and
`<orgname>` with your Fly org name.

```
fly apps create <projectname>-staging --org <orgname>
fly apps create <projectname>-prod --org <orgname>
```

Get your Fly auth token with `fly auth token` and then add it as a repository secret named `FLY_API_TOKEN` on GitHub:
https://github.com/<your-org>/<your-repo>/settings/secrets/actions
