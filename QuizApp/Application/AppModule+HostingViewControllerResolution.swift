import SwiftUI

extension AppModule: RegisterViewsProtocol {

    func registerViews() {
        container
            .register {
                PlaceholderView()
            }
            .scope(.unique)
    }

}
