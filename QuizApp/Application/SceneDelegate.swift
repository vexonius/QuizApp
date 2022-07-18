import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        guard let window = window else { return }

        let mainNavigationController = UINavigationController()
        window.rootViewController = mainNavigationController

        let dependenciesContainer: ContainerProvider = Container()

        let appCoordinator: AppCoordinatorProvider = AppCoordinator(
            navigationController: mainNavigationController,
            container: dependenciesContainer)
        appCoordinator.routeToLogin()

        window.makeKeyAndVisible()
    }

}
