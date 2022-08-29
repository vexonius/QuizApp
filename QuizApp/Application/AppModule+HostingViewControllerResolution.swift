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
    }

}
