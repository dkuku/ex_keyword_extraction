mod tf_idf;
mod tokenizer;
use tf_idf::*;
use tokenizer::*;
rustler::init!(
    "Elixir.ExKeywordExtractionNative",
    [
        tfidf_unprocessed_documents,
        split_into_words,
        split_into_sentences,
        split_into_paragraphs,
        split_into_phrases,
    ]
);
