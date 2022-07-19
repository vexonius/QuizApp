import Foundation
import UIKit

protocol AppCoordinatorProtocol {

    func routeToLogin()

}

class AppCoordinator {

    private var navigationController: UINavigationController
    private var container: ContainerProtocol

    init(navigationController: UINavigationController, container: ContainerProtocol) {
        self.navigationController = navigationController
        self.container = container
    }

}

extension AppCoordinator: AppCoordinatorProtocol {

    func routeToLogin() {
        let loginViewController: UIViewController = container.resolveLoginViewController()
        navigationController.setViewControllers([loginViewController], animated: true)
    }

}
