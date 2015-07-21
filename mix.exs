defmodule TestTimes.Mixfile do
  use Mix.Project

  def project do
    [app: :test_times,
     version: "1.0.0",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end
  
  def application do
    []
  end

  defp deps do
    []
  end

  defp description do
    """
    ExUnit add-on that prints table of test run times with --times flag.
    """
  end

  defp package do
    [
      contributors: ["Paul Infield-Harm"],
      licenses: ["Apache 2.0"],
      links: %{"Github" => "https://github.com/pinfieldharm/test_times"}
    ]
  end

end
