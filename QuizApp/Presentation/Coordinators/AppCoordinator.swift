import Foundation
import UIKit
import Resolver

class AppCoordinator: AppCoordinatorProtocol {

    private let navigationController: UINavigationController
    private let container: Resolver

    init(container: Resolver) {
        self.navigationController = UINavigationController()
        self.container = container
    }

    func routeToLogin() {
        let loginViewController: LoginViewController = container.resolve()
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func setInitialScene(in window: UIWindow) {
        window.rootViewController = navigationController
        routeToLogin()
        window.makeKeyAndVisible()
    }

}
