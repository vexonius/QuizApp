import SwiftUI

extension AppModule: RegisterViewsProtocol {

    func registerViews() {
        container
            .register { container in
                SplashView(viewModel: container.resolve())
            }
            .scope(.unique)
    }

}
