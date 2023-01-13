import UIKit
import SnapKit

protocol HomeViewControllerDisplaying: AnyObject {
    func startLoading(_ shouldHidden: Bool)
    func stopLoading(_ shouldHidden: Bool)
}

final class HomeViewController: UIViewController {
    private let interactor: HomeInteracting
    
    private lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.color = .white
        return loading
    }()
    
    private lazy var titleLabel: Label = {
        let label = Label(ofSize: 28)
        label.text = "Filmes Populares"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
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
        loading.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        tableView.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }
    
    func buildViewHierarchy() {
        view.addSubview(loading)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
    }
}

extension HomeViewController: HomeViewControllerDisplaying {
    func startLoading(_ shouldHidden: Bool) {
        loading.isHidden = shouldHidden
        loading.startAnimating()
    }
    
    func stopLoading(_ shouldHidden: Bool) {
        Task {
            loading.isHidden = shouldHidden
            loading.stopAnimating()
            tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        setupCell(for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140.0
    }
}

private extension HomeViewController {
    func handleResult() {
        Task(priority: .background) {
            await interactor.getTopRated()
        }
    }
    
    func setupCell(for indexPath: IndexPath) -> HomeCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else {
            return HomeCell()
        }
        let model = interactor.movieForCell(at: indexPath)
        cell.setupCell(with: model)
        return cell
    }
}
