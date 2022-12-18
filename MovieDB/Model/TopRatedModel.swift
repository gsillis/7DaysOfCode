struct TopRatedModel: Decodable, Equatable {
    static func == (lhs: TopRatedModel, rhs: TopRatedModel) -> Bool {
        return lhs.page == rhs.page &&
        lhs.results == rhs.results &&
        lhs.totalPages == rhs.totalPages &&
        lhs.totalResults == rhs.totalResults
    }
    
    let page: Int?
    let results: [MovieModel]?
    let totalResults: Int?
    let totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
