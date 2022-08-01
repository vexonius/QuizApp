import UIKit
import Combine
import SnapKit

class SettingsViewController: BaseViewController {

    private struct CustomConstants {
        static let insetTop = 20
        static let inputFieldInset = 4
    }

    private let viewModel: SettingsViewModel

    private var usernameInputLabel: UILabel!
    private var usernameInputField: UITextField!
    private var logoutButton: UIButton!

    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel

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
        bindViews()

        usernameInputField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.title = ""
    }

}

extension SettingsViewController: ConstructViewsProtocol {

    func createViews() {
        usernameInputLabel = UILabel()
        view.addSubview(usernameInputLabel)

        usernameInputField = UITextField()
        view.addSubview(usernameInputField)

        logoutButton = RoundedButton(with: LocalizedStrings.logoutButtonTitle.localizedString)
        view.addSubview(logoutButton)
    }

    func styleViews() {
        usernameInputLabel.font = .sourceSansPro(ofSize: 12)
        usernameInputLabel.text = LocalizedStrings.usernamePlaceholder.localizedString.uppercased()

        usernameInputField.font = .sourceSansPro(ofSize: 20, ofWeight: .bold)

        logoutButton.setTitleColor(.accentRed, for: .normal)
    }

    func defineLayoutForViews() {
        usernameInputLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(CustomConstants.insetTop)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.contentInset)
        }

        usernameInputField.snp.makeConstraints { make in
            make.top.equalTo(usernameInputLabel.snp.bottom).offset(CustomConstants.inputFieldInset)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.contentInset)
        }

        logoutButton.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.componentsInset)
            make.height.equalTo(DesignConstants.InputComponents.height)
        }
    }

}

extension SettingsViewController: BindViewsProtocol {

    func bindViews() {
        viewModel
            .$currentUsername
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: usernameInputField)
            .store(in: &cancellables)

        viewModel
            .$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] errorMessage in
                guard
                    let self = self,
                    let errorMessage = errorMessage
                else { return }

                Snackbar(in: self.view, message: errorMessage).show()
            }
            .store(in: &cancellables)

        logoutButton
            .gesture(.tap())
            .sink { [weak self] _ in
                self?.viewModel.logout()
            }
            .store(in: &cancellables)
    }

}

// MARK: UITextFieldDelegate

extension SettingsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        guard let username = textField.text else { return true }

        viewModel.usernameOnChange(username)

        return true
    }

}