defmodule ExKeywordExtractionTest do
  use ExUnit.Case
  import AssertValue

  describe "rake" do
    setup do
      punctation = ~w/. , : ; ! ? ()  { } " ' -/

      [
        text_rank:
          ExKeywordExtractionNative.r_new(
            example_text(),
            StopWords.en(),
            punctation: punctation
          )
      ]
    end

    test "get_keyword_score", %{text_rank: ref} do
      assert_value ExKeywordExtractionNative.r_get_keyword_score(ref, "elixir") ==
                     2.142857074737549

      assert_value ExKeywordExtractionNative.r_get_keyword_score(ref, "erlang") ==
                     1.600000023841858

      assert_value ExKeywordExtractionNative.r_get_keyword_score(ref, "kuku") == 0.0
    end

    test "get_phrase_score", %{text_rank: ref} do
      assert_value ExKeywordExtractionNative.r_get_phrase_score(
                     ref,
                     "elixir programming language"
                   ) ==
                     2.3531744480133057

      assert_value ExKeywordExtractionNative.r_get_phrase_score(
                     ref,
                     "erlang programming language"
                   ) == 0.0

      assert_value ExKeywordExtractionNative.r_get_phrase_score(ref, "not included") ==
                     0.0
    end

    test "r_get_ranked_keyword", %{text_rank: ref} do
      assert_value ExKeywordExtractionNative.r_get_ranked_keyword(ref, 10) == [
                     "applications",
                     "building",
                     "distributed",
                     "fault",
                     "tolerant",
                     "12",
                     "2018",
                     "builds",
                     "conferences",
                     "created"
                   ]
    end

    test "r_get_ranked_keyword_scores", %{text_rank: ref} do
      assert_value ExKeywordExtractionNative.r_get_ranked_keyword_scores(ref, 10) == [
                     {"applications", 5.0},
                     {"building", 5.0},
                     {"distributed", 5.0},
                     {"fault", 5.0},
                     {"tolerant", 5.0},
                     {"12", 4.0},
                     {"2018", 4.0},
                     {"builds", 4.0},
                     {"conferences", 4.0},
                     {"created", 4.0}
                   ]
    end

    test "r_get_ranked_phrases", %{text_rank: ref} do
      assert_value ExKeywordExtractionNative.r_get_ranked_phrases(ref, 10) == [
                     "building distributed fault tolerant applications elixir",
                     "conferences history josé valim created",
                     "july 12 2018 honeypot released",
                     "community organizes yearly events",
                     "erlang programming language elixir builds",
                     "elixir programming language",
                     "purpose programming language",
                     "minor local events",
                     "elixir",
                     "data volumes elixir"
                   ]
    end

    test "r_get_ranked_phrase_scores", %{text_rank: ref} do
      assert_value ref
                   |> ExKeywordExtractionNative.r_get_ranked_phrase_scores(10)
                   |> Map.new(fn {k, v} -> {k, Float.ceil(v, 2)} end) == %{
                     "building distributed fault tolerant applications elixir" => 4.53,
                     "community organizes yearly events" => 2.88,
                     "conferences history josé valim created" => 4.0,
                     "data volumes elixir" => 2.05,
                     "elixir" => 2.15,
                     "elixir programming language" => 2.36,
                     "erlang programming language elixir builds" => 2.54,
                     "july 12 2018 honeypot released" => 4.0,
                     "minor local events" => 2.17,
                     "purpose programming language" => 2.31
                   }
    end

    test "r_get_word_scores_map", %{text_rank: ref} do
      assert_value ref
                   |> ExKeywordExtractionNative.r_get_word_scores_map()
                   |> Enum.sort_by(&elem(&1, 1), :desc)
                   |> Enum.take(10)
                   |> Enum.map(fn {k, v} -> {k, Float.ceil(v, 2)} end) == [
                     {"applications", 5.0},
                     {"building", 5.0},
                     {"fault", 5.0},
                     {"tolerant", 5.0},
                     {"distributed", 5.0},
                     {"july", 4.0},
                     {"conferences", 4.0},
                     {"12", 4.0},
                     {"created", 4.0},
                     {"valim", 4.0}
                   ]
    end

    test "r_get_phrase_scores_map", %{text_rank: ref} do
      assert_value ref
                   |> ExKeywordExtractionNative.r_get_phrase_scores_map()
                   |> Enum.sort_by(&elem(&1, 1), :desc)
                   |> Enum.take(10)
                   |> Enum.map(fn {k, v} -> {k, Float.ceil(v, 2)} end) == [
                     {"building distributed fault tolerant applications elixir", 4.53},
                     {"july 12 2018 honeypot released", 4.0},
                     {"conferences history josé valim created", 4.0},
                     {"community organizes yearly events", 2.88},
                     {"erlang programming language elixir builds", 2.54},
                     {"elixir programming language", 2.36},
                     {"purpose programming language", 2.31},
                     {"minor local events", 2.17},
                     {"elixir", 2.15},
                     {"data volumes elixir", 2.05}
                   ]
    end
  end

  describe "text rank" do
    setup do
      punctation = ~w/. , : ; ! ? ()  { } " ' -/

      [
        text_rank:
          ExKeywordExtractionNative.tr_new(
            example_text(),
            StopWords.en(),
            punctation: punctation
          )
      ]
    end

    test "get_word_score", %{text_rank: ref} do
      assert_value ExKeywordExtractionNative.tr_get_word_score(ref, "rust") == 0.0

      assert_value ExKeywordExtractionNative.tr_get_word_score(ref, "developer") ==
                     0.0

      assert_value ExKeywordExtractionNative.tr_get_word_score(ref, "kuku") == 0.0
    end

    test "get_phrase_score", %{text_rank: ref} do
      assert_value ExKeywordExtractionNative.tr_get_phrase_score(ref, "rust programming") == 0.0
      assert_value ExKeywordExtractionNative.tr_get_phrase_score(ref, "junior developer") == 0.0

      assert_value ExKeywordExtractionNative.tr_get_phrase_score(ref, "kuku uczy sie rusta") ==
                     0.0
    end

    test "tr_get_ranked_words", %{text_rank: ref} do
      assert_value ExKeywordExtractionNative.tr_get_ranked_words(ref, 10) == [
                     "elixir",
                     "erlang",
                     "language",
                     "programming",
                     "events",
                     "macros",
                     "metaprogramming",
                     "polymorphism",
                     "time",
                     "protocols"
                   ]
    end

    test "tr_get_ranked_word_scores", %{text_rank: ref} do
      assert_value ref
                   |> ExKeywordExtractionNative.tr_get_ranked_word_scores(10)
                   |> Map.new(fn {k, v} -> {k, Float.ceil(v, 2)} end) == %{
                     "elixir" => 4.33,
                     "erlang" => 3.57,
                     "events" => 1.72,
                     "language" => 2.79,
                     "macros" => 0.98,
                     "metaprogramming" => 0.98,
                     "polymorphism" => 0.98,
                     "programming" => 2.09,
                     "protocols" => 0.97,
                     "time" => 0.98
                   }
    end

    test "tr_get_ranked_phrases", %{text_rank: ref} do
      assert_value ExKeywordExtractionNative.tr_get_ranked_phrases(ref, 10) == [
                     "elixir",
                     "erlang",
                     "elixir programming language",
                     "erlang ecosystem elixir",
                     "erlang programming language elixir builds",
                     "ruby erlang",
                     "erlang vm",
                     "data volumes elixir",
                     "purpose programming language",
                     "latency language"
                   ]
    end

    test "tr_get_ranked_phrase_scores", %{text_rank: ref} do
      assert_value ref
                   |> ExKeywordExtractionNative.tr_get_ranked_phrase_scores(10)
                   |> Map.new(fn {k, v} -> {k, Float.ceil(v, 2)} end) == %{
                     "data volumes elixir" => 2.0,
                     "elixir" => 4.33,
                     "elixir programming language" => 3.07,
                     "erlang" => 3.57,
                     "erlang ecosystem elixir" => 2.9,
                     "erlang programming language elixir builds" => 2.71,
                     "erlang vm" => 2.2,
                     "latency language" => 1.81,
                     "purpose programming language" => 1.9,
                     "ruby erlang" => 2.21
                   }
    end

    test "tr_get_word_scores_map", %{text_rank: ref} do
      assert_value ref
                   |> ExKeywordExtractionNative.tr_get_word_scores_map()
                   |> Enum.take(10)
                   |> Map.new(fn {k, v} -> {k, Float.ceil(v, 2)} end) == %{
                     "community" => 0.97,
                     "compile" => 0.97,
                     "concurrency" => 0.83,
                     "develop" => 0.84,
                     "documentary" => 0.7,
                     "japan" => 0.94,
                     "plataformatec" => 0.89,
                     "productivity" => 0.85,
                     "released" => 0.95,
                     "supported" => 0.95
                   }
    end

    test "tr_get_phrase_scores_map", %{text_rank: ref} do
      assert_value ref
                   |> ExKeywordExtractionNative.tr_get_phrase_scores_map()
                   |> Enum.sort_by(&elem(&1, 1), :desc)
                   |> Enum.take(10)
                   |> Enum.map(fn {k, v} -> {k, Float.ceil(v, 2)} end) == [
                     {"elixir", 4.33},
                     {"erlang", 3.57},
                     {"elixir programming language", 3.07},
                     {"erlang ecosystem elixir", 2.9},
                     {"erlang programming language elixir builds", 2.71},
                     {"ruby erlang", 2.21},
                     {"erlang vm", 2.2},
                     {"data volumes elixir", 2.0},
                     {"purpose programming language", 1.9},
                     {"latency language", 1.81}
                   ]
    end
  end

  describe "tokenizer" do
    test "split_into_words" do
      punctation = ~w/. , : ; ! ? ()  { } " ' -/

      result =
        ExKeywordExtractionNative.split_into_words(
          example_text(),
          StopWords.en(),
          punctation
        )

      assert_value length(result) == 96

      assert_value Enum.take(result, 10) == [
                     "elixir",
                     "functional",
                     "concurrent",
                     "level",
                     "purpose",
                     "programming",
                     "language",
                     "runs",
                     "beam",
                     "virtual"
                   ]
    end

    test "split_into_sentences" do
      punctation = ~w/. , : ; ! ? ()  { } " ' -/

      result =
        ExKeywordExtractionNative.split_into_sentences(
          example_text(),
          StopWords.en(),
          punctation
        )

      assert_value length(result) == 25

      assert_value Enum.take(result, 10) == [
                     "elixir functional concurrent level purpose programming",
                     "language runs beam virtual machine implement",
                     "erlang programming language",
                     "elixir builds erlang shares",
                     "abstractions building distributed fault tolerant applications",
                     "elixir",
                     "tooling extensible design",
                     "supported",
                     "compile time metaprogramming macros polymorphism protocols",
                     "community organizes yearly events united europe"
                   ]
    end

    test "split_into_paragraphs" do
      punctation = ~w/. , : ; ! ? ()  { } " ' -/

      result =
        ExKeywordExtractionNative.split_into_paragraphs(
          example_text(),
          StopWords.en(),
          punctation
        )

      assert_value length(result) == 18

      assert_value Enum.take(result, 10) == [
                     "elixir functional concurrent level purpose programming",
                     "language runs beam virtual machine implement",
                     "erlang programming language elixir builds erlang shares",
                     "abstractions building distributed fault tolerant applications elixir",
                     "tooling extensible design supported",
                     "compile time metaprogramming macros polymorphism protocols",
                     "community organizes yearly events united europe",
                     "japan minor local events conferences",
                     "history",
                     "josé valim created elixir programming language"
                   ]
    end

    test "split_into_phrases" do
      punctation = ~w/. , : ; ! ? ()  { } " ' -/

      result =
        ExKeywordExtractionNative.split_into_phrases(
          example_text(),
          StopWords.en(),
          punctation
        )

      assert_value length(result) == 53

      assert_value Enum.take(result, 10) == [
                     "elixir",
                     "functional concurrent",
                     "level",
                     "purpose programming language",
                     "runs",
                     "beam virtual machine",
                     "implement",
                     "erlang programming language elixir builds",
                     "erlang",
                     "shares"
                   ]
    end
  end

  test "greets the world" do
    punctation = ~w/. , : ; ! ? ()  { } " ' \n/

    documents =
      """
      "This is a test document.
      "This is another test document.
      "This is a third test document.
      """
      |> ExKeywordExtractionNative.split_into_paragraphs([], punctation)

    assert_value documents
                 |> ExKeywordExtractionNative.tfidf_get_word_scores_map()
                 |> Map.new(fn {k, v} -> {k, Float.ceil(v, 2)} end) ==
                   %{
                     "a" => 0.38,
                     "another" => 0.25,
                     "document" => 0.44,
                     "is" => 0.44,
                     "test" => 0.44,
                     "third" => 0.25,
                     "this" => 0.44
                   }
  end

  defp example_text do
    """
    Elixir is a functional, concurrent, high-level general-purpose programming
    language that runs on the BEAM virtual machine, which is also used to implement
    the Erlang programming language. Elixir builds on top of Erlang and shares the
    same abstractions for building distributed, fault-tolerant applications. Elixir
    also provides tooling and an extensible design. The latter is supported by
    compile-time metaprogramming with macros and polymorphism via protocols.

    The community organizes yearly events in the United States, Europe, and
    Japan, as well as minor local events and conferences.
    History

    José Valim created the Elixir programming language as a research and
    development project at Plataformatec. His goals were to enable higher
    extensibility and productivity in the Erlang VM while maintaining compatibility
    with Erlang's ecosystem.

    Elixir is aimed at large-scale sites and apps. It uses features of Ruby,
    Erlang, and Clojure to develop a high-concurrency and low-latency language. It
    was designed to handle large data volumes. Elixir is also used in
    telecommunications, e-commerce, and finance.

    On July 12, 2018, Honeypot released a mini-documentary on Elixir.
    """
  end
end
