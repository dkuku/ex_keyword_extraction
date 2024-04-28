defmodule ExKeywordExtractionNative do
  @moduledoc """
  Documentation for `ExKeywordExtraction`.
  """
  use Rustler, otp_app: :ex_keyword_extraction, crate: :exkeywordextractionnative

  def split_into_words(_, _, _), do: error()
  def split_into_sentences(_, _, _), do: error()
  def split_into_paragraphs(_, _, _), do: error()
  def split_into_phrases(_, _, _), do: error()
  def tfidf_get_word_scores_map(_), do: error()
  def tr_new(a, b), do: tr_new(a, b, [])
  def tr_new(_, _, _), do: error()
  def tr_get_phrase_score(_, _), do: error()
  def tr_get_phrase_scores_map(_), do: error()
  def tr_get_ranked_phrase_scores(_, _), do: error()
  def tr_get_ranked_phrases(_, _), do: error()
  def tr_get_ranked_word_scores(_, _), do: error()
  def tr_get_ranked_words(_, _), do: error()
  def tr_get_word_score(_, _), do: error()
  def tr_get_word_scores_map(_), do: error()
  def r_new(a, b), do: r_new(a, b, [])
  def r_new(_, _, _), do: error()
  def r_get_keyword_score(_, _), do: error()
  def r_get_phrase_score(_, _), do: error()
  def r_get_phrase_scores_map(_), do: error()
  def r_get_ranked_keyword(_, _), do: error()
  def r_get_ranked_keyword_scores(_, _), do: error()
  def r_get_ranked_phrase_scores(_, _), do: error()
  def r_get_ranked_phrases(_, _), do: error()
  def r_get_word_scores_map(_), do: error()

  defp error, do: :erlang.nif_error(:nif_not_loaded)
end
