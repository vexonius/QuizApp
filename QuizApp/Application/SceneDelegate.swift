import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var dependenciesContainer: ContainerProvider?

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

        dependenciesContainer = Container()

        guard let dependenciesContainer = dependenciesContainer else { return }

        let appCoordinator: AppCoordinatorProvider = AppCoordinator(
            navigationController: mainNavigationController,
            container: dependenciesContainer)
        appCoordinator.routeToLogin()

        window.makeKeyAndVisible()
    }

}
