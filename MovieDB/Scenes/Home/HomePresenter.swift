import UIKit

protocol HomePresenting {
    func startLoading()
    func stopLoading()
}

final class HomePresenter {
    weak var viewController: HomeViewControllerDisplaying?
}

extension HomePresenter: HomePresenting {
    func startLoading() {
        viewController?.startLoading()
    }
    
    func stopLoading() {
        viewController?.stopLoading()
    }
}
