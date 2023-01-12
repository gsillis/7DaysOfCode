import Foundation
import UIKit

protocol HomeInteracting {
    func getTopRated() async
    func viewDidLoad()
    func movieForCell(at indexPath: IndexPath) async -> HomeCellViewModel
    var numberOfRows: Int { get }
}

final class HomeInteractor {
    private let presenter: HomePresenting
    private let service: HomeServicing
    private var movies = [MovieModel]()
    
    init(presenter: HomePresenting, service: HomeServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension HomeInteractor: HomeInteracting {
    func getMoviePoster() async {
    }
    
    var numberOfRows: Int {
        movies.count
    }
    
    func viewDidLoad() {
        presenter.startLoading(false)
    }
    
    func getTopRated() async {
        let result = await service.getTopRated()
        DispatchQueue.main.async {
            self.presenter.stopLoading(true)
        }
       handleResult(with: result)
    }
    
    func movieForCell(at indexPath: IndexPath) async -> HomeCellViewModel {
        let movie = movies[indexPath.row]
        let path = movie.backdropPath
        
        let image = await ImageDownloader().image(from: MoviesEndpoint.images(path: path ?? ""))
        
        let model = HomeCellViewModel(
            title: movie.title ?? "",
            releaseDate: movie.releaseDate ?? "",
            image: image ?? UIImage()
        )
        return model
    }
}

private extension HomeInteractor {
    func handleResult(with result: Result<TopRatedModel, NetworkError>) {
        switch result {
        case .success(let data):
            if let movieList = data.results {
                movies.append(contentsOf: movieList)
                movies.forEach { movie in
                    movie.backdropPath
                }
            }
        case .failure(let error):
            print(error)
        }
    }
}
