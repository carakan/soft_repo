defmodule SoftRepo.Repo do
  use Ecto.Repo, otp_app: :soft_repo

  # mock pagination
  def paginate(queryable, opts) do
    SoftRepo.Repo.all(queryable, opts)
  end
end

defmodule User do
  use Ecto.Schema
  import SoftRepo.Schema
  import Ecto.Changeset

  schema "users" do
    field(:token, :string)
    field(:username, :string)

    soft_repo_schema()
    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:deleted_at, :token, :username])
    |> validate_required([:token, :username])
  end
end
