import UIKit

final class MovieDetailViewController: UIViewController {
    private var viewInstance: MovieDetailView?
    private let movie: MovieModel
    
    init(movie: MovieModel) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        viewInstance = MovieDetailView()
        view = viewInstance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInstance?.configure(with: movie)
    }
}
