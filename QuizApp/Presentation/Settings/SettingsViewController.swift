import UIKit
import SnapKit

class SettingsViewController: BaseViewController {

    private struct CustomConstants {
        static let insetTop = 114
        static let inputFieldInset = 4
    }

    private var usernameInputLabel: UILabel!
    private var usernameInputField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
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
