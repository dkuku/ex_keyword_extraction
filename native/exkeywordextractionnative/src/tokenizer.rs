use keyword_extraction::tokenizer::Tokenizer;
#[rustler::nif(schedule = "DirtyCpu")]
pub fn split_into_words(
    text: &str,
    stop_words: Vec<String>,
    punctation: Vec<String>,
) -> Vec<String> {
    Tokenizer::new(text, stop_words.as_slice(), get_punctation(&punctation)).split_into_words()
}
#[rustler::nif(schedule = "DirtyCpu")]
pub fn split_into_sentences(
    text: &str,
    stop_words: Vec<String>,
    punctation: Vec<String>,
) -> Vec<String> {
    Tokenizer::new(text, stop_words.as_slice(), get_punctation(&punctation)).split_into_sentences()
}
#[rustler::nif(schedule = "DirtyCpu")]
pub fn split_into_paragraphs(
    text: &str,
    stop_words: Vec<String>,
    punctation: Vec<String>,
) -> Vec<String> {
    Tokenizer::new(text, stop_words.as_slice(), get_punctation(&punctation)).split_into_paragraphs()
}
#[rustler::nif(schedule = "DirtyCpu")]
pub fn split_into_phrases(
    text: &str,
    stop_words: Vec<String>,
    punctation: Vec<String>,
) -> Vec<String> {
    Tokenizer::new(text, stop_words.as_slice(), get_punctation(&punctation))
        .split_into_phrases(None)
}
fn get_punctation(punctation: &Vec<String>) -> Option<&[String]> {
    match punctation {
        v if v.is_empty() => None,
        _ => Some(punctation.as_slice()),
    }
}
