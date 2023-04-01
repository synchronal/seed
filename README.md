# Synchronal Seed

A base for a Phoenix LiveView app.

Includes:

* A sample controller: [Web.StatusController](lib/web/controllers/status_controller.ex)
* A sample LiveView: [Web.HomeLive](lib/web/live/home_live.ex)
* Controller and LiveView tests using [Pages](https://github.com/synchronal/pages) and
  [HtmlQuery](https://github.com/synchronal/html_query/)

It embodies some of our current preferences for building LiveView apps:
* Eschewing the usage of the application name as the root module, and instead using multiple root modules
  such as `Core`, `Web`, and `Test`. (On some of our projects, there are also other root modules such as
  `Etc` and `Extra`.)
* Using [SASS](https://sass-lang.com) instead of Tailwind.
* Using `@related` tags to jump between related files quickly (via
  [related-files](https://github.com/synchronal/related-files)).
