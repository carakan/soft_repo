# SoftRepo

A basic implementation of soft delete using repository pattern (Ecto Repo).

## Installation

* this package can be installed by adding `soft_repo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:soft_repo, "~> 0.1.0"}
  ]
end
```

* Configure `soft_repo` to use your application repo in config/config.exs:

```
config :soft_repo, repo: YourApplicationName.Repo
```

* **Migrations** for schemas to add support for soft deletion, add soft_repo_column() when creating/modifing a table

```elixir
  defmodule MyApp.Repo.Migrations.CreateWhatever do
    use Ecto.Migration

    def change do
      create table(:wjatever) do
        add(:my_field, :string)
        add(:my_other_field, :string)
        timestamps()
        SoftRepo.Migration.soft_repo_column()
      end
    end
  end
```

* **Schema**
Import `SoftRepo.Schema` into your Schema module, then add `soft_repo_schema()` to your schema

```elixir
  defmodule Whatever do
    use Ecto.Schema
    import SoftRepo.Schema

    schema "users" do
      field(:email, :string)
      soft_repo_schema()
    end
  end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/soft_repo](https://hexdocs.pm/soft_repo).

