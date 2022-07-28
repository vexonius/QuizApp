import UIKit

class TabbedViewController: UITabBarController {

    private let homeViewController: HomeViewController
    private let settingsViewController: SettingsViewController

    init(homeViewController: HomeViewController, settingsViewController: SettingsViewController) {
        self.homeViewController = homeViewController
        self.settingsViewController = settingsViewController

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()

        setupChildViewControllers()


        //title = LocalizedStrings.appName.localizedString
    }

    private func setupChildViewControllers() {
        addChild(homeViewController)
        homeViewController.tabBarItem.image = UIImage.quiz
        homeViewController.tabBarItem.selectedImage = UIImage.quiz.withTintColor(.gray)
        homeViewController.tabBarItem.title = LocalizedStrings.quiz.localizedString

        addChild(settingsViewController)
        settingsViewController.tabBarItem.image = UIImage.settings
        settingsViewController.tabBarItem.image = UIImage.settings.withTintColor(.gray)
        settingsViewController.tabBarItem.title = LocalizedStrings.settings.localizedString
    }

}

extension TabbedViewController: ConstructViewsProtocol {

    func createViews() {

    }

    func styleViews() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .darkerPurple 
    }

    func defineLayoutForViews() {

    }

}
