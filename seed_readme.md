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

Replace the first two lines of README.md with something specific for your project.

Remove the "Validating commit messages" step of `bin/dev/audit` because it's only meant for Seed development.

Replace the `:seed` app name with your own by running the following on the command line, changing "my-org" to your org
name, and "my-app" to your app name:

```
APP=my-app ORG=my-org LC_ALL=C find . -type f -exec sed -i '' \
  -e "s/:seed/:$APP/g" \
  -e "s/seed_dev/$APP_dev/g" \
  -e "s/seed_test/$APP_test/g" \
  -e "s/synchronal-seed/$ORG-$APP/g" {} +
```

Run doctor over and over until all issues are fixed:

```
bin/dev/doctor
```

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

See README.md for day-to-day development instructions.

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
