import UIKit
import Combine
import SnapKit

class SettingsViewController: BaseViewController {

    private struct CustomConstants {
        static let insetTop = 114
        static let inputFieldInset = 4
    }

    private let viewModel: SettingsViewModel

    private var usernameInputLabel: UILabel!
    private var usernameInputField: UITextField!

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
    }

    func styleViews() {
        usernameInputLabel.font = .sourceSansPro(ofSize: 12)
        usernameInputLabel.text = LocalizedStrings.usernamePlaceholder.localizedString.uppercased()

        usernameInputField.font = .sourceSansPro(ofSize: 20, ofWeight: .bold)
    }

    func defineLayoutForViews() {
        usernameInputLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CustomConstants.insetTop)
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
        }

        usernameInputField.snp.makeConstraints { make in
            make.top.equalTo(usernameInputLabel.snp.bottom).offset(CustomConstants.inputFieldInset)
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
        }
    }

}

extension SettingsViewController: BindViewsProtocol {

    func bindViews() {
        viewModel
            .$currentUsername
            .assign(to: \.text, on: usernameInputField)
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
