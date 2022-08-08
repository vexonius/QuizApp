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
        registerCoordinators()
        registerkClients()
        registerRepositories()
        registerUseCases()
        registerViewModels()
        registerViewControllers()
    }

    private func registerCoordinators() {
        container
            .register { container in
                AppCoordinator(container: container)
            }
            .implements(AppCoordinatorProtocol.self)
            .scope(.application)
    }

    private func registerkClients() {
        container
            .register { BaseNetworkClient() }
            .implements(BaseNetworkClientProtocol.self)
            .scope(.application)

        container
            .register { container in
                LoginNetworkClient(baseNetworkClient: container.resolve())
            }
            .implements(LoginNetworkClientProtocol.self)
            .scope(.application)

        container
            .register { container in
                AccountNetworkClient(baseNetworkClient: container.resolve())
            }
            .implements(AccountNetworkClientProtocol.self)
            .scope(.application)
    }

    private func registerRepositories() {
        container
            .register { container in
                LoginRepository(networkClient: container.resolve())
            }
            .implements(LoginRepositoryProtocol.self)
            .scope(.application)

        container
            .register { container in
                AccountRepository(accountNetworkClient: container.resolve())
            }
            .implements(AccountRepositoryProtocol.self)
            .scope(.application)
    }

    private func registerUseCases() {
        container
            .register { container in
                LoginUseCase(loginRepository: container.resolve())
            }
            .implements(LoginUseCaseProtocol.self)
            .scope(.graph)

        container
            .register { container in
                AccountUseCase(accountRepository: container.resolve())
            }
            .implements(AccountUseCaseProtocol.self)
            .scope(.graph)
    }

    private func registerViewModels() {
        container
            .register { container in
                SplashViewModel(loginUseCase: container.resolve(), coordinator: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                LoginViewModel(loginUseCase: container.resolve(), coordinator: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                SettingsViewModel(
                    accountUseCase: container.resolve(),
                    loginUsecase: container.resolve(),
                    coordinator: container.resolve())
            }
            .scope(.unique)
    }

    private func registerViewControllers() {
        container
            .register { container in
                SplashViewController(viewModel: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                TabbedViewController(
                    homeViewController: container.resolve(),
                    settingsViewController: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                LoginViewController(viewModel: container.resolve())
            }
            .scope(.unique)

        container
            .register { HomeViewController() }
            .scope(.unique)

        container
            .register { container in
                SettingsViewController(viewModel: container.resolve())
            }
            .scope(.unique)
    }

}
