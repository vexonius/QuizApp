import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var container: ContainerProvider?
    private var appCoordinator: AppCoordinatorProvider?

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

        container = Container()

        guard let container = container else { return }

        appCoordinator = AppCoordinator(navigationController: mainNavigationController, container: container)

        guard let appCoordinator = appCoordinator else { return }

        appCoordinator.routeToLogin()

        window.makeKeyAndVisible()
    }

}
