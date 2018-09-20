defmodule SoftRepo do
  import Ecto.Changeset, only: [change: 2]
  import Ecto.Query, only: [where: 2]
  import Ecto.Queryable, only: [to_query: 1]
  require Ecto.Query

  @repo SoftRepo.Client.repo()

  def all(queryable, opts \\ [])

  def all(queryable, opts = [with_thrash: false]) do
    opts = Keyword.drop(opts, [:with_thrash])
    @repo.all(queryable, opts)
  end

  def all(queryable, opts) do
    opts = Keyword.drop(opts, [:with_thrash])

    queryable
    |> exclude_thrash()
    |> @repo.all(opts)
  end

  def get(queryable, id, opts \\ [])

  def get(queryable, id, opts = [with_thrash: false]) do
    opts = Keyword.drop(opts, [:with_thrash])
    @repo.get(queryable, id, opts)
  end

  def get(queryable, id, opts) do
    opts = Keyword.drop(opts, [:with_thrash])
    queryable = exclude_thrash(queryable)
    @repo.get(queryable, id, opts)
  end

  def delete(struct, opts \\ [])

  def delete(struct, opts) when length(opts) == 0 do
    changeset = change(struct, deleted_at: DateTime.utc_now())
    @repo.update(changeset)
  end

  def delete(struct, opts) when length(opts) > 0 do
    case with_force_option?(opts) do
      true ->
        opts = Keyword.drop(opts, [:force])
        @repo.delete(struct, opts)

      _ ->
        @repo.delete(struct)
    end
  end

  def delete_all(queryable, opts \\ [])

  def delete_all(queryable, opts) when length(opts) == 0 do
    @repo.update_all(queryable, set: [deleted_at: DateTime.utc_now()])
  end

  def delete_all(queryable, opts) when length(opts) > 0 do
    case with_force_option?(opts) do
      true ->
        opts = Keyword.drop(opts, [:force])
        @repo.delete_all(queryable, opts)

      _ ->
        @repo.delete_all(queryable)
    end
  end

  def restore(queryable, id) do
    changeset = change(@repo.get!(queryable, id), deleted_at: nil)
    @repo.update(changeset)
  end

  defp schema_fields(%{from: {_source, schema}}) when schema != nil,
    do: schema.__schema__(:fields)

  defp field_exists?(queryable, column) do
    query = to_query(queryable)
    fields = schema_fields(query)

    Enum.member?(fields, column)
  end

  defp exclude_thrash(queryable) do
    case field_exists?(queryable, :deleted_at) do
      false ->
        queryable

      true ->
        where(queryable, fragment("deleted_at IS NULL"))
    end
  end

  defp with_thrash_option?(opts), do: Keyword.get(opts, :with_thrash)

  defp with_force_option?(opts), do: Keyword.get(opts, :force)

  defdelegate aggregate(queryable, aggregate, field, opts), to: @repo
  defdelegate config(), to: @repo
  defdelegate delete!(struct, opts \\ []), to: @repo
  defdelegate get!(queryable, id, opts \\ []), to: @repo
  defdelegate get_by!(queryable, clauses, opts \\ []), to: @repo
  defdelegate get_by(queryable, clauses, opts \\ []), to: @repo
  defdelegate in_transaction?(), to: @repo
  defdelegate init(arg0, config), to: @repo
  defdelegate insert!(struct, opts \\ []), to: @repo
  defdelegate insert(struct, opts \\ []), to: @repo
  defdelegate insert_all(schema_or_source, entries, opts \\ []), to: @repo
  defdelegate insert_or_update!(changeset, opts \\ []), to: @repo
  defdelegate insert_or_update(changeset, opts \\ []), to: @repo
  defdelegate one!(queryable, opts \\ []), to: @repo
  defdelegate one(queryable, opts \\ []), to: @repo

  @doc """
  Scrivener pagination.
  """
  def paginate(queryable, opts \\ [])

  def paginate(queryable, opts = [with_thrash: false]) do
    opts = Keyword.drop(opts, [:with_thrash])
    @repo.paginate(queryable, opts)
  end

  def paginate(queryable, opts) do
    opts = Keyword.drop(opts, [:with_thrash])
    queryable = exclude_thrash(queryable)
    @repo.paginate(queryable, opts)
  end

  defdelegate preload(structs_or_struct_or_nil, preloads, opts \\ []), to: @repo
  defdelegate rollback(value), to: @repo
  defdelegate start_link(opts \\ []), to: @repo
  defdelegate stop(pid, timeout \\ 5000), to: @repo
  defdelegate stream(queryable, opts), to: @repo
  defdelegate transaction(fun_or_multi, opts \\ []), to: @repo
  defdelegate update!(struct, opts \\ []), to: @repo
  defdelegate update(struct, opts \\ []), to: @repo
  defdelegate update_all(queryable, updates, opts \\ []), to: @repo
end
