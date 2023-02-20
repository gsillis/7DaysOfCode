import Foundation

enum MovieDetailFactory {
    static func make(with movie: MovieModel) -> MovieDetailViewController {
        let viewController = MovieDetailViewController(movie: movie)
        return viewController
    }
}
