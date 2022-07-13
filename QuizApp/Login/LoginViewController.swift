import UIKit

class LoginViewController: BaseViewController {

    var gradientLayer: CAGradientLayer!
    var logoLabel: UILabel!
    var usernameInput: CoreUI.RoundedTextInput!
    var passwordInput: CoreUI.RoundedTextInput!

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()

        usernameInput.delegate = self
        passwordInput.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = view.bounds
    }

}

extension LoginViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? CoreUI.RoundedTextInput {
            textField.styleForInFocus()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? CoreUI.RoundedTextInput {
            textField.styleForOutOfFocus()
        }
    }

}
