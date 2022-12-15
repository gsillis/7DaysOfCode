import UIKit

protocol HomePresenting {
    
}

final class HomePresenter {
    weak var viewController: UIViewController?
}

extension HomePresenter: HomePresenting {
    
}
