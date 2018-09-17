defmodule SoftRepo.Schema do
  @moduledoc """
  Contains schema macros to add soft delete fields to a schema
  """

  @doc """
  Adds the `deleted_at` column to a schema

      defmodule User do
        use Ecto.Schema
        import SoftRepo.Schema

        schema "users" do
          field :email,           :string
          soft_repo_schema()
        end
      end

  """
  defmacro soft_repo_schema do
    quote do
      field(:deleted_at, :utc_datetime)
    end
  end
end
