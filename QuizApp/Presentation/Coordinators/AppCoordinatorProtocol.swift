import UIKit
import Resolver

protocol AppCoordinatorProtocol {

    var navigationController: UINavigationController { get }

    var container: Resolver { get }

    func routeToLogin()

    func setInitialScene(in window: UIWindow)

}
