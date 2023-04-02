[
  import_deps: [:ecto, :moar, :phoenix, :phoenix_html, :phoenix_live_view, :schema_assertions],
  inputs: [
    "*.{ex,exs}",
    "priv/*/seeds.exs",
    "{.medic,config,lib,test}/**/*.{ex,exs}",
    "*.md",
    "guides/*.md"
  ],
  line_length: 120,
  locals_without_parens: [
    assert_that: :*,
    flunk: :*,
    live_component: :*,
    live_redirect: :*,
    on_mount: :*
  ],
  markdown: [
    line_length: 120
  ],
  plugins: [Phoenix.LiveView.HTMLFormatter, MarkdownFormatter],
  subdirectories: ["priv/*/migrations"]
]
