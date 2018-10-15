defmodule SoftRepo.MixProject do
  use Mix.Project

  def project do
    [
      app: :soft_repo,
      deps: deps(),
      description: description(),
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package(),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: "0.3.0"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:logger, :postgrex, :ecto]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.10.1", only: :dev},
      {:ecto, github: "carakan/ecto", branch: "v2.2"},
      {:excoveralls, "~> 0.10.0", only: :test},
      {:ex_doc, "~> 0.19.0", only: :dev},
      {:postgrex, "~> 0.13.0"}
    ]
  end

  defp description do
    """
    Soft delete using Ecto repo.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE", "CHANGELOG.md"],
      maintainers: ["Carlos Ramos"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/carakan/soft_repo"
      },
      build_tools: ["mix"]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
