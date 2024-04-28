use rustler::Env;
use rustler::Term;
mod rake;
mod text_rank;
mod tf_idf;
mod tokenizer;
use rake::*;
use text_rank::*;
use tf_idf::*;
use tokenizer::*;

fn load(env: Env, _info: Term) -> bool {
    rustler::resource!(ExKeywordExtractionRef, env);
    rustler::resource!(ExKeywordExtractionRakeRef, env);
    true
}
rustler::init!(
    "Elixir.ExKeywordExtractionNative",
    [
        tfidf_get_word_scores_map,
        split_into_words,
        split_into_sentences,
        split_into_paragraphs,
        split_into_phrases,
        r_get_keyword_score,
        r_get_phrase_scores_map,
        r_get_phrase_score,
        r_get_ranked_keyword,
        r_get_ranked_keyword_scores,
        r_get_ranked_phrase_scores,
        r_get_ranked_phrases,
        r_get_word_scores_map,
        r_new,
        tr_get_phrase_score,
        tr_get_phrase_scores_map,
        tr_get_ranked_phrase_scores,
        tr_get_ranked_phrases,
        tr_get_ranked_word_scores,
        tr_get_ranked_words,
        tr_get_word_score,
        tr_get_word_scores_map,
        tr_new,
    ],
    load = load
);
