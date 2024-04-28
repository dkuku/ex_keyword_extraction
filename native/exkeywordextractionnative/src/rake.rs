// pub mod error;
use keyword_extraction::rake::Rake;
use keyword_extraction::rake::RakeParams;
use rustler::{Encoder, Env, NifTaggedEnum, ResourceArc, Term};
use std::collections::HashMap;
mod atoms {
    rustler::atoms! {
        ok,
        error,
    }
}
pub struct ExKeywordExtractionRakeRef(Rake);
impl Encoder for ExKeywordExtractionRakeRef {
    fn encode<'a>(&self, env: Env<'a>) -> Term<'a> {
        (atoms::ok(), self).encode(env)
    }
}
impl From<Rake> for ExKeywordExtractionRake {
    fn from(data: Rake) -> Self {
        Self {
            resource: ResourceArc::new(ExKeywordExtractionRakeRef(data)),
        }
    }
}
#[derive(rustler::NifStruct)]
#[module = "ExKeywordExtraction.Rake"]
pub struct ExKeywordExtractionRake {
    pub resource: ResourceArc<ExKeywordExtractionRakeRef>,
}
#[derive(NifTaggedEnum, Debug)]
pub enum RakeParamsPub {
    Punctation(Vec<String>),
    PhraseLength(usize),
}
#[derive(Debug)]
struct RakeParamsPriv<'a> {
    punctation: Option<&'a [String]>,
    phrase_length: Option<usize>,
}
fn get_options<'a>(options: Vec<RakeParamsPub>) -> RakeParamsPriv<'a> {
    let mut opts = RakeParamsPriv {
        punctation: None,
        phrase_length: None,
    };
    options.iter().for_each(|option| match option {
        //RakeParamsPub::Punctation(val) => opts.punctation = Some(val.as_slice()),
        RakeParamsPub::Punctation(_val) => opts.punctation = None,
        RakeParamsPub::PhraseLength(val) => opts.phrase_length = Some(*val),
    });
    opts
}
#[rustler::nif]
pub fn r_new(
    text: &str,
    stop_words: Vec<String>,
    options: Vec<RakeParamsPub>,
) -> ExKeywordExtractionRake {
    let opts = get_options(options);

    let params = RakeParams::All(
        text,
        stop_words.as_slice(),
        opts.punctation,
        opts.phrase_length,
    );
    Rake::new(params).into()
}

#[rustler::nif]
pub fn r_get_keyword_score(reference: ExKeywordExtractionRake, word: &str) -> f32 {
    reference.resource.0.get_keyword_score(word)
}

#[rustler::nif]
pub fn r_get_phrase_score(reference: ExKeywordExtractionRake, phrase: &str) -> f32 {
    reference.resource.0.get_phrase_score(phrase)
}
#[rustler::nif]
pub fn r_get_ranked_keyword(reference: ExKeywordExtractionRake, n: usize) -> Vec<String> {
    reference.resource.0.get_ranked_keyword(n)
}

#[rustler::nif]
pub fn r_get_ranked_keyword_scores(
    reference: ExKeywordExtractionRake,
    n: usize,
) -> Vec<(String, f32)> {
    reference.resource.0.get_ranked_keyword_scores(n)
}

#[rustler::nif]
pub fn r_get_ranked_phrases(reference: ExKeywordExtractionRake, n: usize) -> Vec<String> {
    reference.resource.0.get_ranked_phrases(n)
}

#[rustler::nif]
pub fn r_get_ranked_phrase_scores(
    reference: ExKeywordExtractionRake,
    n: usize,
) -> Vec<(String, f32)> {
    // TODO bug
    reference.resource.0.get_ranked_phrases_scores(n)
}

#[rustler::nif]
pub fn r_get_word_scores_map(reference: ExKeywordExtractionRake) -> HashMap<String, f32> {
    reference.resource.0.get_word_scores_map().clone()
}

#[rustler::nif]
pub fn r_get_phrase_scores_map(reference: ExKeywordExtractionRake) -> HashMap<String, f32> {
    reference.resource.0.get_phrase_scores_map().clone()
}
