import UIKit
import Resolver

class AppModule {

    private let container: Resolver

    init(container: Resolver) {
        self.container = container

        registerDependencies()
    }

    func initRouter(in window: UIWindow) {
        let appCoordinator: AppCoordinatorProtocol = container.resolve()
        appCoordinator.setInitialScene(in: window)
    }

    private func registerDependencies() {
        registerCoordinator()
        registerBaseNetworkClient()
        registerLoginClient()
        registerLoginRepository()
        registerLoginUseCase()
        registerLoginViewModel()
        registerLoginViewController()
    }

    private func registerCoordinator() {
        container
            .register { container in
                AppCoordinator(container: container)
            }
            .implements(AppCoordinatorProtocol.self)
            .scope(.application)
    }

    private func registerBaseNetworkClient() {
        container
            .register { BaseNetworkClient() }
            .implements(BaseNetworkClientProtocol.self)
            .scope(.application)
    }

    private func registerLoginClient() {
        container
            .register { container in
                LoginNetworkClient(baseNetworkClient: container.resolve())
            }
            .implements(LoginNetworkClientProtocol.self)
            .scope(.graph)
    }

    private func registerLoginRepository() {
        container
            .register { container in
                LoginRepository(networkClient: container.resolve())
            }
            .implements(LoginRepositoryProtocol.self)
            .scope(.graph)
    }

    private func registerLoginUseCase() {
        container
            .register { container in
                LoginUseCase(loginRepository: container.resolve())
            }
            .implements(LoginUseCaseProtocol.self)
            .scope(.graph)
    }

    private func registerLoginViewModel() {
        container
            .register { container in
                LoginViewModel(loginUseCase: container.resolve())
            }
            .scope(.unique)
    }

    func registerLoginViewController() {
        container
            .register { container in
                LoginViewController(viewModel: container.resolve())
            }
            .scope(.unique)
    }

}
