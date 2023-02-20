import Foundation

protocol HomeInteracting {
    func getTopRated() async
    func viewDidLoad()
    func movieForCell(at indexPath: IndexPath) -> HomeCellViewModel
    func selectMovie(at indexPath: IndexPath)
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
    var numberOfRows: Int {
        movies.count
    }
    
    func viewDidLoad() {
        presenter.startLoading(false)
    }
    
    func getTopRated() async {
        let result = await service.getTopRated()
        presenter.stopLoading(true)
        handleResult(with: result)
    }
    
    func movieForCell(at indexPath: IndexPath) -> HomeCellViewModel {
        let movie = movies[indexPath.row]
        
        let model = HomeCellViewModel(
            title: movie.title ?? "",
            releaseDate: movie.releaseDateFormatted,
            imagePath: movie.posterPathImage
        )
        return model
    }
    
    func selectMovie(at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        presenter.selectedMovie(movie)
    }
}

private extension HomeInteractor {
    func handleResult(with result: Result<TopRatedModel, NetworkError>) {
        switch result {
        case .success(let data):
            if let movieList = data.results {
                movies.append(contentsOf: movieList)
            }
        case .failure(let error):
            print(error)
        }
    }
}
