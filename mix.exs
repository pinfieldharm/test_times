defmodule TestTimes.Mixfile do
  use Mix.Project

  def project do
    [app: :test_times,
     version: "1.0.0",
     elixir: "~> 1.0",
     description: "Report individual test times in ascending order",
     deps: deps,
     package: package]
  end
  
  def application do
    [applications: []]
  end

  defp deps do
    []
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      contributors: ["Paul Infield-Harm"],
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/pinfieldharm/test_times"}
    ]
  end

end
