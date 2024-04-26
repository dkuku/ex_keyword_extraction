defmodule ExKeywordExtraction.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_keyword_extraction,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:stop_words, "~> 0.1.0"},
      {:rustler, "~> 0.32.1"},
      {:assert_value, ">= 0.0.0", only: [:dev, :test]}
    ]
  end
end
