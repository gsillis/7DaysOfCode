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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .customPurple
        return tableView
    }()
    
    init(interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleResult()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.viewDidLoad()
        buildView()
    }
}

extension HomeViewController: ViewsProtocol {
    func setupView() {
        view.backgroundColor = .customPurple
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func buildViewHierarchy() {
        view.addSubview(loading)
        view.addSubview(tableView)
    }
}

extension HomeViewController: HomeViewControllerDisplaying {
    func startLoading(_ shouldHidden: Bool) {
        loading.isHidden = shouldHidden
        loading.startAnimating()
        tableView.isHidden = true
    }
    
    func stopLoading(_ shouldHidden: Bool) {
        loading.isHidden = shouldHidden
        loading.stopAnimating()
        tableView.isHidden = false
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else { return UITableViewCell() }
        let model = interactor.movieForCell(at: indexPath)
        cell.setupCell(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.numberOfRows
    }
}

private extension HomeViewController {
    func handleResult() {
        Task(priority: .background) {
            await interactor.getTopRated()
        }
    }
}
