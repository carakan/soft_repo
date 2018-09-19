Mix.Task.run("ecto.drop")
Mix.Task.run("ecto.create")
Mix.Task.run("ecto.migrate")

SoftRepo.Repo.start_link()
ExUnit.start()
