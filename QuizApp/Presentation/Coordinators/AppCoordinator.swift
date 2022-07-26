import Foundation
import UIKit
import Resolver

class AppCoordinator: AppCoordinatorProtocol {

    private (set) var navigationController: UINavigationController
    private (set) var container: Resolver

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