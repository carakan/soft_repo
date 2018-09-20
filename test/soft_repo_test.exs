defmodule SoftRepoTest do
  use ExUnit.Case
  doctest SoftRepo
  @repo SoftRepo.Client.repo()

  test "list all records with one already soft deleted" do
    user = create_user()
    user = create_user()
    create_user(%{deleted_at: DateTime.utc_now()})
    assert Enum.count(@repo.all(User)) == 3, "Show normal result"
    assert Enum.count(SoftRepo.all(User)) == 2, "using soft-delete"
    assert Enum.count(SoftRepo.all(User, [with_thrash: false])) == 3, "with trash option"
    assert Enum.count(SoftRepo.all(User, with_thrash: true)) == 2, "set false for trash option"
  end

  defp create_user(params \\ %{}) do
    %User{}
    |> User.changeset(Map.merge(%{token: "dummy-token", username: "myusername"}, params))
    |> @repo.insert!
  end
end
