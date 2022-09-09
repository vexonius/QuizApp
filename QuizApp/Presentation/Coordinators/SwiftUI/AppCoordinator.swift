import Foundation
import UIKit
import SwiftUI
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
        let loginView: LoginView = container.resolve()
        let loginViewController = UIHostingController(rootView: loginView)
        navigationController.setViewControllers([loginViewController], animated: true)
    }

    func routeToHomeScreen() {
        let tabbedView: TabbedView = container.resolve()
        let viewController = UIHostingController(rootView: tabbedView)
        navigationController.setViewControllers([viewController], animated: true)
    }

    func setInitialScene(in window: UIWindow) {
        window.rootViewController = navigationController
        let splashView: SplashView = container.resolve()
        let viewController = UIHostingController(rootView: splashView)
        navigationController.setViewControllers([viewController], animated: true)
        window.makeKeyAndVisible()
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }

    private func styleNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.setBackIndicatorImage(UIImage.backArrow, transitionMaskImage: UIImage.backArrow)
        appearance.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.sourceSansPro(
                ofSize: DesignConstants.FontSize.title.cgFloat,
                ofWeight: .bold)!]

        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.tintColor = .white
    }

}

extension AppCoordinator: QuizCoordinatorProtocol {

    func routeToLeaderBoard(for quizId: Int) {

    }

    func routeToQuizDetails(quiz: QuizModel) {

    }

    func play(quiz: QuizModel) {

    }

    func finishQuiz(with result: QuizResultModel) {

    }

}
