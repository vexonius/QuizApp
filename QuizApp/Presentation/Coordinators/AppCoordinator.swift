import Foundation
import UIKit
import Resolver

class AppCoordinator: AppCoordinatorProtocol {

    private(set) var navigationController: UINavigationController
    private(set) var container: Resolver

    init(container: Resolver) {
        self.navigationController = UINavigationController()
        self.container = container
    }

    func routeToLogin() {
        let loginViewController: LoginViewController = container.resolve()
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func routeToHomeScreen() {
        let homeViewController: HomeViewController = container.resolve()
        navigationController.setViewControllers([homeViewController], animated: true)
    }

    func setInitialScene(in window: UIWindow) {
        window.rootViewController = navigationController
        let splashViewController: SplashViewController = container.resolve()
        navigationController.setViewControllers([splashViewController], animated: true)
        window.makeKeyAndVisible()
    }

}
