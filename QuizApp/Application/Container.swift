import Resolver

protocol ContainerProtocol {

    func resolveLoginViewController() -> LoginViewController

}

class Container {

    private let resolver: Resolver

    init() {
        resolver = Resolver.main
        registerDependencies()
    }

}

extension Container: ContainerProtocol {

    private func registerDependencies() {
        registerBaseNetworkClient()
        registerLoginClient()
        registerLoginRepository()
        registerLoginUseCase()
        registerLoginViewModel()
    }

    private func registerBaseNetworkClient() {
        resolver
            .register { BaseNetworkClient() }
            .implements(BaseNetworkClientProtocol.self)
            .scope(.application)
    }

    private func registerLoginClient() {
        resolver
            .register { resolver in
                LoginNetworkClient(baseNetworkClient: resolver.resolve())
            }
            .implements(LoginNetworkClientProtocol.self)
            .scope(.graph)
    }

    private func registerLoginRepository() {
        resolver
            .register { resolver in
                LoginRepository(networkClient: resolver.resolve())
            }
            .implements(LoginRepositoryProtocol.self)
            .scope(.graph)
    }

    private func registerLoginUseCase() {
        resolver
            .register { resolver in
                LoginUseCase(loginRepository: resolver.resolve())
            }
            .implements(LoginUseCaseProtocol.self)
            .scope(.graph)
    }

    private func registerLoginViewModel() {
        resolver
            .register { resolver in
                LoginViewModel(loginUseCase: resolver.resolve())
            }
            .scope(.unique)
    }

    func resolveLoginViewController() -> LoginViewController {
        let viewModel: LoginViewModel = resolver.resolve()
        let viewController: LoginViewController = LoginViewController(viewModel: viewModel)

        return viewController
    }

}
