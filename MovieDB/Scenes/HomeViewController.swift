import UIKit

final class ViewController: UIViewController {

    let service = ApiRequestService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handlResult()
    }

    func getTopRated() async -> Result<TopRatedModel, NetworkError> {
        return await service.fetchMovies(endpoint: MoviesEndpoint.topRated, with: TopRatedModel.self)
    }
    
    func handlResult() {
        Task(priority: .background) {
            let result = await getTopRated()
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

