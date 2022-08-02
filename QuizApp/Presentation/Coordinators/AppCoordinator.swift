import Foundation
import UIKit
import Resolver

class AppCoordinator: AppCoordinatorProtocol {

    private(set) var navigationController: UINavigationController
    private(set) var container: Resolver

    init(container: Resolver) {
        self.navigationController = UINavigationController()
        self.container = container

        styleNavigationBar()
    }

    func routeToLogin() {
        let loginViewController: LoginViewController = container.resolve()
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func routeToHomeScreen() {
        let tabbedViewController: TabbedViewController = container.resolve()
        navigationController.setViewControllers([tabbedViewController], animated: true)
    }

    func setInitialScene(in window: UIWindow) {
        window.rootViewController = navigationController
        let splashViewController: SplashViewController = container.resolve()
        navigationController.setViewControllers([splashViewController], animated: true)
        window.makeKeyAndVisible()
    }

    private func styleNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont.sourceSansPro(ofSize: 24, ofWeight: .bold)]
        UINavigationBar.appearance().standardAppearance = appearance
    }

}
