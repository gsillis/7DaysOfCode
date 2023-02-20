import UIKit

final class MockNavigationController: UINavigationController {
    private let rootViewController: UIViewController
    
    override init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set)var pushViewControllerCallsCount: Int = 0
    private(set) var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCallsCount += 1
        pushedViewController = viewController
    }
}
