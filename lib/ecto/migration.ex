defmodule SoftRepo.Migration do
  @moduledoc """
  Contains functions to add soft delete columns to a table during migrations
  """

  use Ecto.Migration

  @doc """
  Adds deleted_at column to a table. This column is used to track if an item is deleted or not and when

      defmodule MyApp.Repo.Migrations.CreateWhatever do
        use Ecto.Migration

        def change do
          create table(:whatever) do
            add(:other_field, :string)
            add(:another_field, :string)
            timestamps()
            SoftRepo.Migration.soft_repo_column()
          end
        end
      end

  """
  def soft_repo_column do
    add(:deleted_at, :utc_datetime, default: nil, null: true)
  end

  @doc """
  Adds index for deleted_at column to a table.

      defmodule MyApp.Repo.Migrations.CreateWhatever do
        use Ecto.Migration
        import SoftRepo.Migration

        def change do
          create table(:whatever) do
            add(:other_field, :string)
            add(:another_field, :string)
            timestamps()
            soft_repo_column()
          end
          soft_repo_index(:users)
        end
      end

  """
  def soft_repo_index(table_name) do
    create index(table_name, :deleted_at)
  end
end
