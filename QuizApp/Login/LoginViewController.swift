import UIKit

class LoginViewController: UIViewController {

    var gradientLayer: CAGradientLayer!
    var logoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
    }

}
