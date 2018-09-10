# SoftRepo

A basic implementation of soft delete using repository pattern (Ecto Repo).

## Installation

* If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `soft_repo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:soft_repo, "~> 0.1.0"}
  ]
end
```

* Configure paper_trail to use your application repo in config/config.exs:

```
config :soft_repo, repo: YourApplicationName.Repo
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/soft_repo](https://hexdocs.pm/soft_repo).

