import UIKit

final class HomeViewController: UIViewController {
    private let interactor: HomeInteracting
    
    init(interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
        view.backgroundColor = .red
    }
}

private extension HomeViewController {
    func fetchMovies() {
        Task(priority: .background) {
            await interactor.handleResult()
        }
    }
}
