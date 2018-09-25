# SoftRepo

A basic implementation of soft delete using repository pattern (Ecto Repo).

## Installation

- this package can be installed by adding `soft_repo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:soft_repo, "~> 0.2.0"}
  ]
end
```

- Configure `soft_repo` to use your application repo in config/config.exs:

```
config :soft_repo, repo: YourApplicationName.Repo
```

- **Migrations** for schemas to add support for soft deletion, add soft_repo_column() when creating/modifing a table

```elixir
  defmodule MyApp.Repo.Migrations.CreateWhatever do
    use Ecto.Migration

    def change do
      create table(:whatever) do
        add(:my_field, :string)
        add(:my_other_field, :string)
        timestamps()
        SoftRepo.Migration.soft_repo_column()
      end
    end
  end
```

- **Schema**
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

- **Queries**

```elixir
SoftRepo.get(MyApp.User, 1) # will return nil if record is in soft delete state
SoftRepo.get(MyApp.User, 1, with_thrash: true) # will return the soft deleted record
SoftRepo.all(MyApp.User) # will exclude soft deleted records
SoftRepo.all(MyApp.User, with_thrash: true) # will include soft deleted records
SoftRepo.delete(user) # will update the deleted_at column
SoftRepo.delete(user, force: true) # will permanently delete the record
SoftRepo.delete_all(MyApp.User) # will updated the deleted_at columns
SoftRepo.delete_all(MyApp.User, force: true) # will permanently delete all records
SoftRepo.restore(MyApp.User, 1) # will restore back the soft deleted record
```

## Inspiration

- [Gist](https://gist.github.com/ahmadshah/83a695ac66d98a833d6d576815e6931d)
- [ecto_soft_delete](https://github.com/revelrylabs/ecto_soft_delete)
