defmodule SoftRepoTest do
  use ExUnit.Case
  doctest SoftRepo
  @repo SoftRepo.Client.repo()

  setup do
    @repo.delete_all(User)

    on_exit(fn ->
      @repo.delete_all(User)
    end)

    :ok
  end

  test "method all: create records with one already soft deleted" do
    create_user()
    create_user()
    create_user(%{deleted_at: DateTime.utc_now()})
    assert Enum.count(@repo.all(User)) == 3, "Show normal result"
    assert(Enum.count(SoftRepo.all(User)) == 2, "Using soft-delete")
    assert Enum.count(SoftRepo.all(User, with_thrash: true)) == 3, "set false for trash option"
    assert Enum.count(SoftRepo.all(User, with_thrash: false)) == 2, "with trash option"
  end

  test "method get: create record soft deleted" do
    user = create_user(%{deleted_at: DateTime.utc_now()})
    assert @repo.get(User, user.id), "Show normal result"
    refute SoftRepo.get(User, user.id), "Show normal result"
    assert SoftRepo.get(User, user.id, with_thrash: true), "Show normal result"
    refute SoftRepo.get(User, user.id, with_thrash: false), "Show normal result"
  end

  test "method delete: create records with one already soft deleted" do
    user = create_user()
    create_user()
    create_user(%{deleted_at: DateTime.utc_now()})
    SoftRepo.delete(user)
    assert Enum.count(@repo.all(User)) == 3, "Show normal result"
    assert(Enum.count(SoftRepo.all(User)) == 1, "Using soft-delete")

    SoftRepo.restore(User, user.id)
    assert Enum.count(@repo.all(User)) == 3, "Show normal result with restore"
    assert(Enum.count(SoftRepo.all(User)) == 2, "Using soft-delete restore")

    SoftRepo.delete(user, force: false)
    assert Enum.count(@repo.all(User)) == 3, "Show normal result with force delete"
    assert(Enum.count(SoftRepo.all(User)) == 1, "Using soft-delete with force delete")

    SoftRepo.delete(user, force: true)
    assert Enum.count(@repo.all(User)) == 2, "Show normal result with force delete"
    assert(Enum.count(SoftRepo.all(User)) == 1, "Using soft-delete with force delete")
  end

  test "method delete_all: records with one already soft deleted" do
    user = create_user()
    create_user()
    create_user(%{deleted_at: DateTime.utc_now()})
    SoftRepo.delete_all(User)
    assert Enum.count(@repo.all(User)) == 3, "Show normal result"
    assert(SoftRepo.all(User) == [], "Using soft-delete")

    SoftRepo.delete_all(User, force: false)
    assert Enum.count(@repo.all(User)) == 3, "Show normal result"
    assert(SoftRepo.all(User) == [], "Using soft-delete")

    SoftRepo.delete_all(User, force: true)
    assert @repo.all(User) == [], "Show normal result"
    assert(SoftRepo.all(User) == [], "Using soft-delete")
  end

  defp create_user(params \\ %{}) do
    %User{}
    |> User.changeset(Map.merge(%{token: "dummy-token", username: "myusername"}, params))
    |> @repo.insert!
  end
end
