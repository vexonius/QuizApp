import Foundation
import UIKit

protocol AppCoordinatorProvider {

    func routeToLogin()

}

class AppCoordinator: AppCoordinatorProvider {

    private var navigationController: UINavigationController
    private var container: ContainerProvider

    init(navigationController: UINavigationController, container: ContainerProvider) {
        self.navigationController = navigationController
        self.container = container
    }

    func routeToLogin() {
        let loginViewController: UIViewController = LoginViewController(viewModel: LoginViewModel())
        navigationController.setViewControllers([loginViewController], animated: true)
    }

}
