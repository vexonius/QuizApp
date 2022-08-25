extension AppModule: RegisterViewsProtocol {

    // swiftlint:disable:next function_body_length
    func registerViews() {
        container
            .register { container in
                SplashViewController(viewModel: container.resolve())
            }
            .scope(.unique)

        container
            .register { container in
                TabbedViewController(
                    homeViewController: container.resolve(),
                    searchViewController: container.resolve(),
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
                SearchViewController(viewModel: container.resolve())
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

        container
            .register { container, args in
                QuizResultViewController(viewModel: container.resolve(args: args))
            }
            .scope(.unique)
    }

}
