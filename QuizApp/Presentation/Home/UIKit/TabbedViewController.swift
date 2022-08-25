import UIKit

class TabbedViewController: UITabBarController {

    private let homeViewController: HomeViewController
    private let settingsViewController: SettingsViewController
    private let searchViewController: SearchViewController

    init(
        homeViewController: HomeViewController,
        searchViewController: SearchViewController,
        settingsViewController: SettingsViewController
    ) {
        self.homeViewController = homeViewController
        self.searchViewController = searchViewController
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
    }

    private func setupChildViewControllers() {
        addChild(homeViewController)
        homeViewController.tabBarItem.image = UIImage.quiz
        homeViewController.tabBarItem.selectedImage = UIImage.quiz.withTintColor(.gray)
        homeViewController.tabBarItem.title = LocalizedStrings.quiz.localizedString

        addChild(searchViewController)
        searchViewController.tabBarItem.image = UIImage.search
        searchViewController.tabBarItem.selectedImage = UIImage.search.withTintColor(.gray)
        searchViewController.tabBarItem.title = LocalizedStrings.search.localizedString

        addChild(settingsViewController)
        settingsViewController.tabBarItem.image = UIImage.settings
        settingsViewController.tabBarItem.image = UIImage.settings.withTintColor(.gray)
        settingsViewController.tabBarItem.title = LocalizedStrings.settings.localizedString
    }

}

extension TabbedViewController: ConstructViewsProtocol {

    func createViews() {
        setupChildViewControllers()
    }

    func styleViews() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .darkerPurple
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func defineLayoutForViews() {

    }

}
