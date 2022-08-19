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
        registerClients()
        registerServices()
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
            .implements(QuizCoordinatorProtocol.self)
            .scope(.application)
    }

    private func registerClients() {
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

        container
            .register { container in
                QuizNetworkClient(baseNetworkClient: container.resolve())
            }
            .implements(QuizNetworkClientProtocol.self)
            .scope(.application)
    }

    private func registerServices() {
        container
            .register { NetworkService() }
            .implements(NetworkServiceProtocol.self)
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

        container
            .register { container in
                QuizRepository(quizNetworkClient: container.resolve())
            }
            .implements(QuizRepositoryProtocol.self)
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

        container
            .register { container in
                QuizUseCase(quizRepository: container.resolve())
            }
            .implements(QuizUseCaseProtocol.self)
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

        container
            .register { container in
                HomeViewModel(
                    quizUseCase: container.resolve(),
                    coordinator: container.resolve(),
                    networkService: container.resolve())
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizDetailsViewModel(quiz: args.get(), coordinator: container.resolve())
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizLeaderboardViewModel(
                    quizId: args.get(),
                    quizUseCase: container.resolve(),
                    coordinator: container.resolve())
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizAnsweringViewModel(
                    quiz: args.get(),
                    quizUseCase: container.resolve(),
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
            .register { container in
                HomeViewController(viewModel: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                SettingsViewController(viewModel: container.resolve())
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizDetailsViewController(viewModel: container.resolve(args: args))
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizLeaderboardViewController(viewModel: container.resolve(args: args))
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizAnsweringViewController(viewModel: container.resolve(args: args))
            }
            .scope(.unique)
    }

}
