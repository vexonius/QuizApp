protocol ContainerProtocol {

    func resolveLoginViewController() -> LoginViewController

}

class Container: ContainerProtocol {

    func resolveLoginViewController() -> LoginViewController {
        let viewModel: LoginViewModel = LoginViewModel()
        let viewController: LoginViewController = LoginViewController(viewModel: viewModel)

        return viewController
    }

}
