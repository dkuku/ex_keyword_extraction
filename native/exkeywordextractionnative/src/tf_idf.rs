use keyword_extraction::tf_idf::{TfIdf, TfIdfParams};
use std::collections::HashMap;

#[rustler::nif(schedule = "DirtyCpu")]
pub fn tfidf_get_word_scores_map(documents: Vec<String>) -> HashMap<String, f32> {
    let params = TfIdfParams::ProcessedDocuments(documents.as_slice());
    TfIdf::new(params).get_word_scores_map().to_owned()
}
