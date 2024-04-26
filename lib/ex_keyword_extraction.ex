defmodule ExKeywordExtractionNative do
  @moduledoc """
  Documentation for `ExKeywordExtraction`.
  """
  use Rustler, otp_app: :ex_keyword_extraction, crate: :exkeywordextractionnative

  def tfidf_unprocessed_documents(_, _, _), do: error()
  def split_into_words(_, _, _), do: error()
  def split_into_sentences(_, _, _), do: error()
  def split_into_paragraphs(_, _, _), do: error()
  def split_into_phrases(_, _, _), do: error()

  defp error, do: :erlang.nif_error(:nif_not_loaded)
end
