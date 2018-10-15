defmodule Repo.Migrations.AddTestUsers do
  use Ecto.Migration
  import SoftRepo.Migration

  def change do
    create table(:users) do
      add(:token, :string, null: false)
      add(:username, :string, null: false)
      soft_repo_column()
      timestamps()
    end

    create table(:subscriptions) do
      add(:user_id, references("users"))
      add(:service, :string)
      soft_repo_column()
      timestamps()
    end

    create(index(:users, [:token]))
    soft_repo_index(:users)
  end
end
