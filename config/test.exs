use Mix.Config

config :soft_repo, repo: SoftRepo.Repo

config :soft_repo, SoftRepo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: "soft_repo_test",
  hostname: System.get_env("POSTGRES_HOST"),
  poolsize: 10
