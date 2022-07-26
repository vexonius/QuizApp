import UIKit
import Resolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appModule: AppModule?
    private let container = Resolver.main

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        appModule = AppModule(container: container)

        guard let window = window, let appModule = appModule else { return }

        appModule.initRouter(in: window)
    }

}
