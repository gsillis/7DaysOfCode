import UIKit

protocol HomeCoordinating {
    func showDetails(with movie: MovieModel)
}

final class HomeCoordinator {
    weak var viewController: UIViewController?
}

extension HomeCoordinator: HomeCoordinating {
    func showDetails(with movie: MovieModel) {
        let detailViewController = MovieDetailFactory.make(with: movie)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
