defmodule SoftRepoTest do
  use ExUnit.Case
  doctest SoftRepo

  test "greets the world" do
    assert SoftRepo.hello() == :world
  end
end
