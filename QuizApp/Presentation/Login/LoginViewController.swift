import Combine
import UIKit
import SnapKit

class LoginViewController: BaseViewController {

    private var viewModel: LoginViewModel!

    private var cancellables: Set<AnyCancellable> = []

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
        static let componentsSpacing = 18

        static let buttonDisabledOpacity = 0.6
        static let buttonEnabledOpacity = 1.0
    }

    init(viewModel: LoginViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        bindViews()

        adaptComponentsForOrientationChanges()

        usernameInput.delegate = self
        passwordInput.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        gradientLayer.frame = view.bounds
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        adaptComponentsForOrientationChanges()
    }

    private func adaptComponentsForOrientationChanges() {
        let spacing = view.traitCollection.verticalSizeClass == .regular ?
            CustomConstants.usernameInputOffset :
            CustomConstants.usernameInputLandscapeOffset
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

        componentsStackView.spacing = CustomConstants.componentsSpacing.cgFloat
        componentsStackView.axis = .vertical
        componentsStackView.alignment = .center
        componentsStackView.distribution = .fill
    }

    func defineLayoutForViews() {
        componentsStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.componentsInset)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }

        logoLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        componentsContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
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

// MARK: View Bindings

extension LoginViewController: BindViewsProtocol {

    func bindViews() {
        bindViewModel()
        bindViewComponents()
    }

    func bindViewModel() {
        viewModel
            .$isLoginButtonEnabled
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellables)

        viewModel
            .$isLoginButtonEnabled
            .receive(on: RunLoop.main)
            .sink { [weak self] isEnabled in
                self?.loginButton.alpha = isEnabled ?
                    CustomConstants.buttonEnabledOpacity :
                    CustomConstants.buttonDisabledOpacity
            }
            .store(in: &cancellables)

        viewModel
            .$isPasswordHidden
            .receive(on: RunLoop.main)
            .assign(to: \.isSecureTextEntry, on: passwordInput)
            .store(in: &cancellables)

        viewModel
            .$isUsernameInputEnabled
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: usernameInput)
            .store(in: &cancellables)

        viewModel
            .$isPasswordInputEnabled
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: passwordInput)
            .store(in: &cancellables)
    }

    func bindViewComponents() {
        loginButton
            .gesture(.tap())
            .sink { [weak self] _ in
                self?.viewModel.login()
            }
            .store(in: &cancellables)

        usernameInput
            .textDidChange
            .sink { [weak self] email in
                self?.viewModel.onEmailChanged(email)
            }
            .store(in: &cancellables)

        passwordInput
            .textDidChange
            .sink { [weak self] password in
                self?.viewModel.onPasswordChanged(password)
            }
            .store(in: &cancellables)

        passwordInput
            .rightView?
            .tap
            .sink { [weak self] _ in
                self?.viewModel.togglePasswordVisibility()
            }
            .store(in: &cancellables)
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }

}
