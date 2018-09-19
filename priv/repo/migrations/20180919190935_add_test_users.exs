defmodule Repo.Migrations.AddTestUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:token, :string, null: false)
      add(:username, :string, null: false)
      SoftRepo.Migration.soft_repo_column()

      timestamps()
    end

    create(index(:users, [:token]))
  end
end
