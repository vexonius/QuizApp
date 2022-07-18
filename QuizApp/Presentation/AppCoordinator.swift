import Foundation
import UIKit

protocol AppCoordinatorProvider {

    var navigationController: UINavigationController { get set }

    func routeToLogin()
}

class AppCoordinator: AppCoordinatorProvider {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func routeToLogin() {
        let loginViewController: UIViewController = LoginViewController(viewModel: LoginViewModel())
        navigationController.pushViewController(loginViewController, animated: true)
    }

}
