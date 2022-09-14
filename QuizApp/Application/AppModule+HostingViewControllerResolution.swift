import SwiftUI

extension AppModule: RegisterViewsProtocol {

    func registerViews() {
        container
            .register { container in
                SplashView(viewModel: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                LoginView(viewModel: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                SettingsView(viewModel: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                HomeView(viewModel: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                TabbedView(
                    settingsViewModel: container.resolve(),
                    homeViewModel: container.resolve()
                )
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizDetailsView(viewModel: container.resolve(args: args))
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizLeaderboardView(viewModel: container.resolve(args: args))
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizAnsweringView(viewModel: container.resolve(args: args))
            }
            .scope(.unique)

        container
            .register { container, args in
                QuizResultView(viewModel: container.resolve(args: args))
            }
            .scope(.unique)
    }

}
