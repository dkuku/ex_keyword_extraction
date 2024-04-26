use keyword_extraction::tf_idf::{TfIdf, TfIdfParams};

#[rustler::nif]
pub fn tfidf_unprocessed_documents(
    documents: Vec<String>,
    stop_words: Vec<String>,
    punctation: Vec<String>,
) -> i64 {
    let params = TfIdfParams::UnprocessedDocuments(
        documents.as_slice(),
        stop_words.as_slice(),
        Some(punctation.as_slice()),
    );
    let tf_idf = TfIdf::new(params);
    let ranked_keywords: Vec<String> = tf_idf.get_ranked_words(10);
    let ranked_keywords_scores: Vec<(String, f32)> = tf_idf.get_ranked_word_scores(10);

    println!("{:?}", ranked_keywords);
    println!("{:?}", ranked_keywords_scores);
    1
}
