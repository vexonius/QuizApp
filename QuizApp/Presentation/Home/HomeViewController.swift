import UIKit

class HomeViewController: BaseViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.title = LocalizedStrings.appName.localizedString
    }

}
