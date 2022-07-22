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
        let loginViewController = createViewController(of: LoginViewController.self)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

}

// MARK: Viewcontroller factories

extension AppCoordinator {

    private func createViewController<T: UIViewController>(of type: T.Type) -> UIViewController {
        switch type.self {
        case is LoginViewController.Type:
            return LoginViewController(viewModel: container.resolveLoginViewModel())
        default:
            fatalError("ViewController class not found, terminating...")
        }
    }

}
