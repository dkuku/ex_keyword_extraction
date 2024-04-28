// pub mod error;
use keyword_extraction::text_rank::TextRank;
use keyword_extraction::text_rank::TextRankParams;
use rustler::{Encoder, Env, NifTaggedEnum, ResourceArc, Term};
use std::collections::HashMap;
mod atoms {
    rustler::atoms! {
        ok,
        error,
    }
}
pub struct ExKeywordExtractionRef(TextRank);
impl Encoder for ExKeywordExtractionRef {
    fn encode<'a>(&self, env: Env<'a>) -> Term<'a> {
        (atoms::ok(), self).encode(env)
    }
}
impl From<TextRank> for ExKeywordExtractionTextRank {
    fn from(data: TextRank) -> Self {
        Self {
            resource: ResourceArc::new(ExKeywordExtractionRef(data)),
        }
    }
}
#[derive(rustler::NifStruct)]
#[module = "ExKeywordExtraction.TextRank"]
pub struct ExKeywordExtractionTextRank {
    pub resource: ResourceArc<ExKeywordExtractionRef>,
}
#[derive(NifTaggedEnum, Debug)]
pub enum TextRankParamsPub {
    Punctation(Vec<String>),
    WindowSize(usize),
    DampingFactor(f32),
    MinDiff(f32),
    PhraseLength(usize),
}
#[derive(Debug)]
struct TextRankParamsPriv<'a> {
    punctation: Option<&'a [String]>,
    window_size: usize,
    damping_factor: f32,
    min_diff: f32,
    phrase_length: Option<usize>,
}
fn get_options<'a>(options: Vec<TextRankParamsPub>) -> TextRankParamsPriv<'a> {
    let mut opts = TextRankParamsPriv {
        punctation: None,
        phrase_length: None,
        window_size: 2,
        damping_factor: 0.85,
        min_diff: 0.00005,
    };
    options.iter().for_each(|option| match option {
        //TextRankParamsPub::Punctation(val) => opts.punctation = Some(val.as_slice()),
        TextRankParamsPub::Punctation(_val) => opts.punctation = None,
        TextRankParamsPub::WindowSize(val) => opts.window_size = *val,
        TextRankParamsPub::DampingFactor(val) => opts.damping_factor = *val,
        TextRankParamsPub::MinDiff(val) => opts.min_diff = *val,
        TextRankParamsPub::PhraseLength(val) => opts.phrase_length = Some(*val),
    });
    opts
}
#[rustler::nif(schedule = "DirtyCpu")]
pub fn tr_new(
    text: &str,
    stop_words: Vec<String>,
    options: Vec<TextRankParamsPub>,
) -> ExKeywordExtractionTextRank {
    let opts = get_options(options);

    let params = TextRankParams::All(
        text,
        stop_words.as_slice(),
        opts.punctation,
        opts.window_size,
        opts.damping_factor,
        opts.min_diff,
        opts.phrase_length,
    );
    TextRank::new(params).into()
}

#[rustler::nif]
pub fn tr_get_word_score(reference: ExKeywordExtractionTextRank, word: &str) -> f32 {
    reference.resource.0.get_word_score(word)
}

#[rustler::nif]
pub fn tr_get_phrase_score(reference: ExKeywordExtractionTextRank, phrase: &str) -> f32 {
    reference.resource.0.get_phrase_score(phrase)
}
#[rustler::nif]
pub fn tr_get_ranked_words(reference: ExKeywordExtractionTextRank, n: usize) -> Vec<String> {
    reference.resource.0.get_ranked_words(n)
}

#[rustler::nif]
pub fn tr_get_ranked_word_scores(
    reference: ExKeywordExtractionTextRank,
    n: usize,
) -> Vec<(String, f32)> {
    reference.resource.0.get_ranked_word_scores(n)
}

#[rustler::nif]
pub fn tr_get_ranked_phrases(reference: ExKeywordExtractionTextRank, n: usize) -> Vec<String> {
    reference.resource.0.get_ranked_phrases(n)
}

#[rustler::nif]
pub fn tr_get_ranked_phrase_scores(
    reference: ExKeywordExtractionTextRank,
    n: usize,
) -> Vec<(String, f32)> {
    reference.resource.0.get_ranked_phrase_scores(n)
}

#[rustler::nif]
pub fn tr_get_word_scores_map(reference: ExKeywordExtractionTextRank) -> HashMap<String, f32> {
    reference.resource.0.get_word_scores_map().clone()
}

#[rustler::nif]
pub fn tr_get_phrase_scores_map(reference: ExKeywordExtractionTextRank) -> HashMap<String, f32> {
    reference.resource.0.get_phrase_scores_map().clone()
}
