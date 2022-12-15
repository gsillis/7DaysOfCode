enum HomeFactory {
    static func make() -> HomeViewController {
        let service = HomeService()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter, service: service)
        let viewController = HomeViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
