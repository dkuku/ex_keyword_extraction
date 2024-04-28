defmodule ExKeywordExtraction.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_keyword_extraction,
      version: "0.1.0",
      elixir: "~> 1.14",
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
      {:stop_words, "~> 0.1.0"},
      {:rustler, "~> 0.32.1"},
      {:assert_value, ">= 0.0.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    "ex_keyword_extraction is an elixir wrapper for keyword_extraction crate - it includes the following algorithms: TF-IDF, Rake, TextRank"
  end

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        # "native/ex/.cargo",
        "native/exkeywordextractionnative/src",
        "native/exkeywordextractionnative/Cargo*",
        "README*"
      ],
      licenses: ["LGPL-3.0"],
      links: %{
        "GitHub" => "https://github.com/dkuku/ex_keyword_extraction",
        "Crate GitHub" => "https://github.com/tugascript/keyword-extraction-rs"
      }
    ]
  end
end
