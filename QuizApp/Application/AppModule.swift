import UIKit
import Resolver

class AppModule {

    private(set) var container: Resolver

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
        registerViews()
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

        container
            .register { SecureStorage() }
            .implements(SecureStorageProtocol.self)
            .scope(.application)
    }

    private func registerRepositories() {
        container
            .register { container in
                LoginRepository(networkClient: container.resolve(), secureStorage: container.resolve())
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

    // swiftlint:disable:next function_body_length
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
            .scope(.shared)

        container
            .register { container in
                SearchViewModel(
                    quizUseCase: container.resolve(),
                    coordinator: container.resolve(),
                    networkService: container.resolve())
            }
            .scope(.shared)

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

        container
            .register { container, args in
                QuizResultViewModel(
                    userResult: args.get(),
                    quizUseCase: container.resolve(),
                    coordinator: container.resolve())
            }
            .scope(.unique)
    }

}
