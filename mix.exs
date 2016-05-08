defmodule Ex1090.Mixfile do
  use Mix.Project

  def project do
    [app: :ex1090,
     version: "0.0.1",
     elixir: "~> 1.2",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: app_list(Mix.env)]
  end

  defp app_list(_), do: app_list
  defp app_list, do: [:logger, :httpoison]

  defp deps do
    [
      {:httpoison, "~> 0.7.4"},
      {:poison, "~> 1.5"},
    ]
  end

  defp description do
    """
    client library ex1090 json api.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      keywords: ["Elixir", "Plane", "REST", "HTTP"],
      maintainers: ["Mathieu Leduc-Hamel"],
      links: %{"GitHub" => "https://github.com/mlhamel/exl_1090"}
    ]
  end
end
