defmodule ExKeywordExtractionTest do
  use ExUnit.Case
  import AssertValue

  describe "tokenizer" do
    test "split_into_words" do
      punctation = ~w/. , : ; ! ? () [ ] { } " ' -/

      result =
        ExKeywordExtractionNative.split_into_words(
          example_text(),
          StopWords.en(),
          punctation
        )

      assert_value length(result) == 134

      assert_value Enum.take(result, 10) == [
                     "title",
                     "junior",
                     "rust",
                     "developer",
                     "job",
                     "description",
                     "seeking",
                     "talented",
                     "motivated",
                     "junior"
                   ]
    end

    test "split_into_sentences" do
      punctation = ~w/. , : ; ! ? () [ ] { } " ' -/

      result =
        ExKeywordExtractionNative.split_into_sentences(
          example_text(),
          StopWords.en(),
          punctation
        )

      assert_value length(result) == 27

      assert_value Enum.take(result, 10) == [
                     "title junior rust developer",
                     "job description",
                     "seeking talented motivated junior rust developer growing team",
                     "ideal candidate passion programming strong foundation rust desire learn grow dynamic environment",
                     "responsibilities",
                     "assist development maintenance core rust applications",
                     "write clean efficient documented code",
                     "collaborate development team design implement features",
                     "actively participate code reviews provide constructive feedback",
                     "continuously learn stay rust ecosystem trends technologies"
                   ]
    end

    test "split_into_paragraphs" do
      punctation = ~w/. , : ; ! ? () [ ] { } " ' -/

      result =
        ExKeywordExtractionNative.split_into_paragraphs(
          example_text(),
          StopWords.en(),
          punctation
        )

      assert_value length(result) == 26

      assert_value Enum.take(result, 10) == [
                     "title junior rust developer",
                     "job description",
                     "seeking talented motivated junior rust developer growing team ideal candidate passion programming strong foundation rust desire learn grow dynamic environment",
                     "responsibilities",
                     "assist development maintenance core rust applications",
                     "write clean efficient documented code",
                     "collaborate development team design implement features",
                     "actively participate code reviews provide constructive feedback",
                     "continuously learn stay rust ecosystem trends technologies",
                     "requirements"
                   ]
    end

    test "split_into_phrases" do
      punctation = ~w/. , : ; ! ? () [ ] { } " ' -/

      result =
        ExKeywordExtractionNative.split_into_phrases(
          example_text(),
          StopWords.en(),
          punctation
        )

      assert_value length(result) == 63

      assert_value Enum.take(result, 10) == [
                     "title junior rust developer job description",
                     "seeking",
                     "talented",
                     "motivated junior rust developer",
                     "growing team",
                     "ideal candidate",
                     "passion",
                     "programming",
                     "strong foundation",
                     "rust"
                   ]
    end
  end

  test "greets the world" do
    punctation = ~w/. , : ; ! ? () [ ] { } " '/

    documents = [
      "This is a test document.",
      "This is another test document.",
      "This is a third test document."
    ]

    assert ExKeywordExtractionNative.tfidf_unprocessed_documents(
             documents,
             StopWords.en(),
             punctation
           ) ==
             1
  end

  defp example_text do
    """
    Title: Junior Rust Developer

    Job Description:

    We are seeking a talented and motivated Junior Rust Developer to join our growing team. The ideal candidate will have a passion for programming, a strong foundation in Rust, and a desire to learn and grow in a dynamic work environment.

    Responsibilities:

    Assist in the development and maintenance of our core Rust applications
    Write clean, efficient, and well-documented code
    Collaborate with the development team to design and implement new features
    Actively participate in code reviews and provide constructive feedback
    Continuously learn and stay up-to-date with the latest Rust ecosystem trends and technologies

    Requirements:

    Bachelor's degree in Computer Science or related field, or equivalent experience
    Proficiency in Rust programming language
    Familiarity with version control systems, preferably Git
    Strong problem-solving and debugging skills
    Excellent written and verbal communication skills
    Ability to work well in a team-oriented environment

    Nice-to-Haves:

    Experience with other programming languages, such as Python, JavaScript, or C++
    Knowledge of database systems, like PostgreSQL or MongoDB
    Familiarity with web development frameworks, such as Actix or Rocket

    What We Offer:

    Competitive salary and benefits package
    Opportunity for growth and career advancement
    Supportive and collaborative work environment
    Chance to work on cutting-edge projects using Rust

    If you are passionate about Rust development and looking to kickstart your career in a supportive and dynamic environment, we encourage you to apply!
    """
  end
end
