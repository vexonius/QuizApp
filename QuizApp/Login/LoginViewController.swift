import UIKit

class LoginViewController: BaseViewController {

    var gradientLayer: CAGradientLayer!
    var logoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
    }

}
