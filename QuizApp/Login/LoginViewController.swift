import UIKit
import SnapKit

class LoginViewController: BaseViewController {

    private var gradientLayer: CAGradientLayer!
    private var logoLabel: UILabel!
    private var usernameInput: CoreUI.RoundedTextInput!
    private var passwordInput: CoreUI.RoundedTextInput!

    private let gradientStartPoint = CGPoint(x: 0.5, y: 1)
    private let gradientEndPoint = CGPoint(x: 0.5, y: 0)

    private struct CustomConstants {
        static let logoLabelTopOffset = 76
        static let usernameInputOffset = 144
    }

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

    // MARK: ConstructViewsProtocol

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)

        logoLabel = UILabel()
        view.addSubview(logoLabel)

        usernameInput = CoreUI.RoundedTextInput(type: .username)
        view.addSubview(usernameInput)

        passwordInput = CoreUI.RoundedTextInput(type: .password)
        view.addSubview(passwordInput)
    }

    func styleViews() {
        gradientLayer.type = .axial
        gradientLayer.startPoint = gradientStartPoint
        gradientLayer.endPoint = gradientEndPoint
        gradientLayer.colors = [UIColor.darkerPurple.cgColor, UIColor.lighterPurple.cgColor]

        logoLabel.text = LocalizedStrings.appName.localizedString
        logoLabel.textAlignment = .center
        logoLabel.textColor = .white
        logoLabel.font = .sourceSansPro(
            ofSize: CGFloat(DesignConstants.FontSize.heading),
            ofWeight: SourceSansProWeight.bold)
    }

    func defineLayoutForViews() {
        logoLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(DesignConstants.InputComponents.height)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(CustomConstants.logoLabelTopOffset)
            make.centerX.equalToSuperview()
        }

        usernameInput.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.componentsInset)
            make.height.equalTo(DesignConstants.InputComponents.height)
            make.top.equalTo(logoLabel.snp.bottom).offset(CustomConstants.usernameInputOffset)
            make.centerX.equalToSuperview()
        }

        passwordInput.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.componentsInset)
            make.height.equalTo(DesignConstants.InputComponents.height)
            make.top.equalTo(usernameInput.snp.bottom).offset(DesignConstants.Insets.componentSpacing)
            make.centerX.equalToSuperview()
        }
    }

}

// MARK: UITextFieldDelegate

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
