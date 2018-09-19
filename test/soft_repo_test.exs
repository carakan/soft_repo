defmodule SoftRepoTest do
  use ExUnit.Case
  doctest SoftRepo
  @repo SoftRepo.Client.repo()

  test "list all records" do
    user = create_user()
    assert @repo.all(User)
  end

  defp create_user do
    User.changeset(%User{}, %{token: "fake-token", username: "izelnakri"}) |> @repo.insert!
  end
end
