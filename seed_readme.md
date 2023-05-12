# Synchronal Seed

A base for a Phoenix LiveView app. It is meant to be set up as a git remote to a Phoenix app, so that as your Seed-based
project matures, changes to Seed can be optionally merged in from the remote. As your Seed-based project matures, it
will naturally diverge from what's in the Seed repo, and merging in from the remote may get more difficult. At that
point, it might be more useful to just read the code changes and apply any interesting changes via copy & paste.

Includes:

- A sample controller: [Web.StatusController](lib/web/controllers/status_controller.ex)
- A sample LiveView: [Web.HomeLive](lib/web/live/home_live.ex)
- Controller and LiveView tests using [Pages](https://github.com/synchronal/pages) and [HtmlQuery](https://github.com/synchronal/html_query/)
- Dev dependencies via [ASDF](https://asdf-vm.com) and [Homebrew](https://brew.sh)
- Dev machine management via [Medic](https://github.com/synchronal/medic)

It embodies some of our current preferences for building LiveView apps:

- Eschews the usage of the application name as the root module, and instead uses multiple root modules such as `Core`,
  `Web`, and `Test`. (On some of our projects, there are also other root modules such as `Etc` and `Extra`.)
- Uses [SASS](https://sass-lang.com) instead of Tailwind.
- Uses `@related` tags to jump between related files quickly (via
  [related-files](https://github.com/synchronal/related-files)).
- On a dev computer, stores the Postgres data in the project directory (in `./priv/postgres`) and supports multiple
  versions of Postgres running simultaneously on the same dev computer.

It also embodies some of our current preferences for CI and deploying:

- Uses GitHub actions for running tests.
- Passing builds are automatically deployed to staging on [Fly](https://fly.io).
- A successful staging deploy will trigger a production deploy on Fly.

Remember that this is just starter code, and you can change any of these preferences after creating your project.

## Usage

### Creating a new project using `seed` as a base

Create a new, empty git repo:

```
mkdir foo
cd foo
git init .
```

Set this repo as a remote, fetch it, and merge it:

```
git remote add seed https://github.com/synchronal/seed.git
git fetch seed
git merge seed/main
```

You may get a few errors related to `envrc` but you can ignore them for now.

Run doctor over and over until all issues are fixed:

```
bin/dev/doctor
```

This will end up creating local databases called `seed_dev` and `seed_test` which you'll delete later.

Run the tests:

```
bin/dev/test
```

Run Phoenix and view it in a browser:

```
bin/dev/start
open "http://localhost:4000/"
```

### Day-to-day development of a Seed-based project

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

### Configuring deployments

This section assumes you're deploying to [Fly](https://fly.io) via GitHub actions. Otherwise you're on your own :)

Make sure you have a Fly org via `fly orgs list` and if not, create one via `fly orgs create`.

Create Fly staging and prod apps if you haven't already, replacing `<projectname>` with your project name and
`<orgname>` with your Fly org name.

```
fly apps create <projectname>-staging --org <orgname>
fly apps create <projectname>-prod --org <orgname>
```

Replace the project name in `deploy.yml`:

```
sed -i '' -e 's/synchronal-seed/<projectname>/g' .github/workflows/deploy.yml
```

Get your Fly auth token with `fly auth token` and then add it as a repository secret named `FLY_API_TOKEN` on GitHub:
https://github.com/<your-org>/<your-repo>/settings/secrets/actions

## Contributing

All commit messages must start with `[seed]` because these commits will become part of the project that is being written
on top of Seed, and it should be clear which commits came from Seed and which are native to the project. For example:

```
[seed] add example Ecto query
```

All work is done on version branches (e.g., `v0.1.0`). When the version is ready, its commits should be squashed into a
single commit and merged into the `main` branch with the version number as the commit message subject and some
description of the changes below. Like all other commits, the message must start with `[seed]`. For example:

```
[seed] v1.2.3

- Added blah blah.
- Updated blah blah.
```
