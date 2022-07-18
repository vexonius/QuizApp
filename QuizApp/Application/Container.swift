import Foundation

protocol ContainerProvider {

    func resolveLoginViewController() -> LoginViewController

}

class Container: ContainerProvider {

    func resolveLoginViewController() -> LoginViewController {
        let viewModel: LoginViewModel = LoginViewModel()
        let viewController: LoginViewController = LoginViewController(viewModel: viewModel)

        return viewController
    }

}
