# Synchronal Seed

A base for a Phoenix LiveView app.

Includes:

* A sample controller: [Web.StatusController](lib/web/controllers/status_controller.ex)
* A sample LiveView: [Web.HomeLive](lib/web/live/home_live.ex)
* Controller and LiveView tests using [Pages](https://github.com/synchronal/pages) and
  [HtmlQuery](https://github.com/synchronal/html_query/)
* Dev dependencies via [ASDF](https://asdf-vm.com) and [Homebrew](https://brew.sh)
* Dev machine management via [Medic](https://github.com/synchronal/medic)

It embodies some of our current preferences for building LiveView apps:
* Eschews the usage of the application name as the root module, and instead uses multiple root modules
  such as `Core`, `Web`, and `Test`. (On some of our projects, there are also other root modules such as
  `Etc` and `Extra`.)
* Uses [SASS](https://sass-lang.com) instead of Tailwind.
* Uses `@related` tags to jump between related files quickly (via
  [related-files](https://github.com/synchronal/related-files)).
* On a dev computer, stores the Postgres data in the project directory (in `./priv/postgres`)
  and supports multiple versions of Postgres running simultaneously on the same dev computer.

## Usage

### Creating a new project using `seed` as a base

1. Create a new, empty git repo:

    ```
    mkdir foo
    cd foo
    git init .
    ```

2. Set this repo as a remote, fetch it, and merge it:

    ```
    git remote add seed https://github.com/synchronal/seed.git
    git fetch seed
    git merge seed/main
    ```

    You may get a few errors related to `envrc` but you can ignore them for now.

3. Run doctor over and over until all issues are fixed:

    ```
    bin/dev/doctor
    ```

    This will end up creating local databases called `seed_dev` and `seed_test` which you'll delete later.

4. Run the tests:

    ```
    bin/dev/test
    ```

5. Run Phoenix and view it in a browser:

    ```
    bin/dev/start
    open "http://localhost:4000/"
    ```

## Contributing

All commit messages must start with `[seed]` because these commits will become part of the project that is
being written on top of Seed. For example:

    ```
    [seed] add example Ecto query
    ```

All work is done on version branches (e.g., `v0.1.0`). When the version is ready, its commits should be squashed
and merged into main with the version number as the commit message subject and some description of the changes
below. Like all other commits, the message must start with `[seed]`. For example:

    ```
    [seed] v1.2.3

    - Added blah blah.
    - Updated blah blah.
    ```

