defmodule SoftRepoTest do
  use ExUnit.Case
  doctest SoftRepo
  @repo SoftRepo.Client.repo()

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

  defp create_user(params \\ %{}) do
    %User{}
    |> User.changeset(Map.merge(%{token: "dummy-token", username: "myusername"}, params))
    |> @repo.insert!
  end
end
