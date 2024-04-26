defmodule ExKeywordExtractionNative do
  @moduledoc """
  Documentation for `ExKeywordExtraction`.
  """
  use Rustler, otp_app: :ex_keyword_extraction, crate: :exkeywordextractionnative

  def add(_, _), do: error()

  defp error, do: :erlang.nif_error(:nif_not_loaded)
end
