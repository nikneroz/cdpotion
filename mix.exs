defmodule CDPotion.MixProject do
  use Mix.Project

  def project do
    [
      app: :cdpotion,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "A Chrome DevTools Protocol client in Elixir",
      package: package(),
      licenses: ["MIT"],
      maintainers: ["Denis Rozenkin"],
      links: %{
        "GitHub" => "https://github.com/nikneroz/cdpotion"
      }
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
    []
  end

  defp package do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      maintainers: ["Denis Rozenkin"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/nikneroz/cdpotion"
      }
    ]
  end
end
