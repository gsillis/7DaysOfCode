@testable import MovieDB

extension TopRatedModel {
    static func fixture(page: Int = 1,
                        results: [MovieModel] = [MovieModel.fixture()],
                        totalResults: Int = 1,
                        totalPages: Int = 1) -> TopRatedModel {
        return .init(
            page: page,
            results: results,
            totalResults: totalResults,
            totalPages: totalPages
        )
    }
}

