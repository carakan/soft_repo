defmodule SoftRepo.Repo do
  use Ecto.Repo, otp_app: :soft_repo

  # mock pagination
  def paginate(queryable, opts) do
    SoftRepo.Repo.all(queryable, opts)
  end

  if Mix.env() in [:dev, :test] do
    @spec truncate(Ecto.Schema.t()) :: :ok
    def truncate(schema) do
      table_name = schema.__schema__(:source)
      query("TRUNCATE #{table_name} CASCADE", [])
      :ok
    end
  end
end

defmodule User do
  use Ecto.Schema
  import SoftRepo.Schema
  import Ecto.Changeset

  schema "users" do
    field(:token, :string)
    field(:username, :string)
    has_many(:subscriptions, Subscription, on_delete: :soft_delete_all)

    soft_repo_schema()
    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:deleted_at, :token, :username])
    |> validate_required([:token, :username])
  end
end

defmodule Subscription do
  use Ecto.Schema
  import SoftRepo.Schema
  import Ecto.Changeset

  schema "subscriptions" do
    field(:service, :string)
    belongs_to(:user, User)

    soft_repo_schema()
    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:service, :user_id])
    |> validate_required([:service])
  end
end
