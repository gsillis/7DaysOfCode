import UIKit

protocol HomePresenting {
    func startLoading(_ shouldHidden: Bool)
    func stopLoading(_ shouldHidden: Bool)
}

final class HomePresenter {
    weak var viewController: HomeViewControllerDisplaying?
}

extension HomePresenter: HomePresenting {
    func startLoading(_ shouldHidden: Bool) {
        viewController?.startLoading(shouldHidden)
    }
    
    func stopLoading(_ shouldHidden: Bool) {
        viewController?.stopLoading(shouldHidden)
    }
}
