import UIKit

protocol HomeViewControllerDisplaying: AnyObject {
    func startLoading(_ shouldHidden: Bool)
    func stopLoading(_ shouldHidden: Bool)
}

final class HomeViewController: UIViewController {
    private let interactor: HomeInteracting
    
    private lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.color = .white
        return loading
    }()
    
    init(interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        interactor.viewDidLoad()
        handleResult()
    }
}

extension HomeViewController: ViewsProtocol {
    func setupView() {
        view.backgroundColor = .red
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func buildViewHierarchy() {
        view.addSubview(loading)
    }
}

extension HomeViewController: HomeViewControllerDisplaying {
    func startLoading(_ shouldHidden: Bool) {
        loading.isHidden = shouldHidden
        loading.startAnimating()
    }
    
    func stopLoading(_ shouldHidden: Bool) {
        loading.isHidden = shouldHidden
        loading.stopAnimating()
    }
}

private extension HomeViewController {
    func handleResult() {
        Task(priority: .background) {
            await interactor.handleResult()
        }
    }
}
