defmodule SoftRepo.Repo do
  use Ecto.Repo, otp_app: :soft_repo
end

defmodule User do
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field(:token, :string)
    field(:username, :string)

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:token, :username])
    |> validate_required([:token, :username])
  end
end
