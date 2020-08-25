struct ImdbSuggestionResponse: Decodable {
    // data
    let d: [Result]?

    struct Result: Decodable {
        // id
        let id: String

        // name
        let l: String
    }
}
