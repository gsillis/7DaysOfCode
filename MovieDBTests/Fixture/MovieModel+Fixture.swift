@testable import MovieDB

extension MovieModel {
    static func fixture(posterPath: String = "any_path",
                        adult: Bool = false,
                        overview: String = "any_overview",
                        releaseDate: String = "any_releaseDate",
                        genreIDS: [Int] = [1, 2],
                        id: Int = 1,
                        originalTitle: String = "any_title",
                        originalLanguage: String = "any_br",
                        title: String = "title",
                        backdropPath: String = "any_backdropPath",
                        popularity: Double = 0.0,
                        voteCount: Int = 1,
                        video: Bool = false,
                        voteAverage: Double = 10.0
                        
    ) -> MovieModel {
        return .init(posterPath: posterPath,
                          adult: adult,
                          overview: overview,
                          releaseDate: releaseDate,
                          genreIDS: genreIDS,
                          id: id,
                          originalTitle: originalTitle,
                          originalLanguage: originalLanguage,
                          title: title,
                          backdropPath: backdropPath,
                          popularity: popularity,
                          voteCount: voteCount,
                          video: video,
                          voteAverage: voteAverage
        )
    }
}

