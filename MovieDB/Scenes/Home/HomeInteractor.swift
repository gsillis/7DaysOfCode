import Foundation

protocol HomeInteracting {
    func getTopRated() async
    func viewDidLoad()
    func movieForCell(at indexPath: IndexPath) -> HomeCellViewModel
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
        let url = MoviesEndpoint.image(path: movie.posterPath ?? "").path
        let date = movie.releaseDate?.formatDate() ?? ""
        
        let model = HomeCellViewModel(
            title: movie.title ?? "",
            releaseDate: "Lançamento: \(date)",
            imagePath: URL(string: url)
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
            }
        case .failure(let error):
            print(error)
        }
    }
}
