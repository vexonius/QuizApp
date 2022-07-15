import UIKit
import SnapKit

class LoginViewController: BaseViewController {

    private var gradientLayer: CAGradientLayer!
    private var logoLabel: UILabel!
    private var usernameInput: RoundedTextInput!
    private var passwordInput: RoundedTextInput!
    private var loginButton: RoundedButton!
    private var componentsStackView: UIStackView!
    private var componentsContainerView: UIView!

    private let gradientStartPoint = CGPoint(x: 0.5, y: 1)
    private let gradientEndPoint = CGPoint(x: 0.5, y: 0)

    private struct CustomConstants {
        static let logoLabelTopOffset = 76
        static let usernameInputOffset = 144.0
        static let usernameInputLandscapeOffset = 30.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        adaptComponentsForOrientationChanges()

        usernameInput.delegate = self
        passwordInput.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = view.bounds
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        adaptComponentsForOrientationChanges()
    }

    private func adaptComponentsForOrientationChanges() {
        let spacing = UIDevice.current.orientation.isLandscape ?
            CustomConstants.usernameInputLandscapeOffset :
            CustomConstants.usernameInputOffset
        componentsStackView.setCustomSpacing(spacing, after: logoLabel)
    }

}

    // MARK: ConstructViewsProtocol

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)

        componentsStackView = UIStackView()
        view.addSubview(componentsStackView)

        logoLabel = UILabel()
        componentsStackView.addArrangedSubview(logoLabel)

        componentsContainerView = UIView()
        componentsStackView.addArrangedSubview(componentsContainerView)

        usernameInput = RoundedTextInput(type: .username)
        componentsContainerView.addSubview(usernameInput)

        passwordInput = RoundedTextInput(type: .password)
        componentsContainerView.addSubview(passwordInput)

        loginButton = RoundedButton(with: LocalizedStrings.loginButtonTitle.localizedString)
        componentsContainerView.addSubview(loginButton)
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
            ofSize: DesignConstants.FontSize.heading.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        componentsStackView.spacing = 18
        componentsStackView.axis = .vertical
        componentsStackView.alignment = .center
        componentsStackView.distribution = .fill
    }

    func defineLayoutForViews() {
        componentsStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.componentsInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }

        logoLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        componentsContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }

        usernameInput.snp.makeConstraints { make in
            make.top.equalTo(componentsContainerView)
            make.width.equalToSuperview()
            make.height.equalTo(DesignConstants.InputComponents.height)
            make.centerX.equalToSuperview()
        }

        passwordInput.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(DesignConstants.InputComponents.height)
            make.top.equalTo(usernameInput.snp.bottom).offset(DesignConstants.Insets.componentSpacing)
            make.centerX.equalToSuperview()
        }

        loginButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(DesignConstants.InputComponents.height)
            make.top.equalTo(passwordInput.snp.bottom).offset(DesignConstants.Insets.componentSpacing)
            make.centerX.equalToSuperview()
        }
    }

}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? RoundedTextInput else { return }

        textField.styleForInFocus()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? RoundedTextInput else { return }

        textField.styleForOutOfFocus()
    }

}
