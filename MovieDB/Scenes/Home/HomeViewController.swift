import UIKit

protocol HomeViewControllerDisplaying: AnyObject {
    func startLoading()
    func stopLoading()
}

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
        view.backgroundColor = .red
        handleResult()
    }
}

extension HomeViewController: HomeViewControllerDisplaying {
    func startLoading() {}
    
    func stopLoading() {}
}

private extension HomeViewController {
    func handleResult() {
        Task(priority: .background) {
            await interactor.handleResult()
        }
    }
}
