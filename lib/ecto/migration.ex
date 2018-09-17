defmodule SoftRepo.Migration do
  @moduledoc """
  Contains functions to add soft delete columns to a table during migrations
  """

  use Ecto.Migration

  @doc """
  Adds deleted_at column to a table. This column is used to track if an item is deleted or not and when

      defmodule MyApp.Repo.Migrations.CreateUser do
        use Ecto.Migration

        def change do
          create table(:users) do
            add :email, :string
            add :password, :string
            timestamps()
            SoftRepo.Migration.soft_repo_column()
          end
        end
      end

  """
  def soft_repo_column do
    add(:deleted_at, :utc_datetime, [])
  end
end
