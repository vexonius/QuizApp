import SwiftUI

extension AppModule: RegisterViewsProtocol {

    func registerViews() {
        container
            .register {
                SplashView()
            }
            .scope(.unique)
    }

}
