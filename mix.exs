defmodule SoftRepo.MixProject do
  use Mix.Project

  def project do
    [
      app: :soft_repo,
      version: "0.1.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.10.1", only: :dev},
      {:ecto, ">= 2.0.0 and < 3.0.0"},
      {:ex_doc, "~> 0.19.0", only: :dev}
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
end
