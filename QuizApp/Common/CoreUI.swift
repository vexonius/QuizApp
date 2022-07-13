import Foundation
import UIKit

class CoreUI {

    enum RoundedTextInputType {
        case username
        case password
        case `default`
    }

    private enum RoundedTextInputAttributes: String {
        case placeholderText = "placeholder text"
    }

    class RoundedTextInput: UITextField {

        private var type: RoundedTextInputType = .default
        private let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        init(type: RoundedTextInputType) {
            super.init(frame: .zero)

            self.type = type

            style()
            setContentType()
            setBorder()
            setPlaceholder()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func textRect(forBounds bounds: CGRect) -> CGRect {
            bounds.inset(by: padding)
        }

        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            bounds.inset(by: padding)
        }

        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            bounds.inset(by: padding)
        }

        func styleForInFocus() {
            layer.borderWidth = 1
        }

        func styleForOutOfFocus() {
            layer.borderWidth = 0
        }

        private func style() {
            backgroundColor = .textFieldBackground
            tintColor = .white
            textColor = .white

            layer.borderColor = UIColor.white.cgColor
            layer.cornerRadius = 22
            layer.cornerCurve = .continuous

            attributedPlaceholder = NSAttributedString(
                string: RoundedTextInputAttributes.placeholderText.rawValue,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

            font = self.isFocused ?
                UIFont.sourceSansPro(ofSize: 16, ofWeight: .semibold) :
                UIFont.sourceSansPro(ofSize: 16, ofWeight: .semibold)
        }

        private func setContentType() {
            switch type {
            case .username:
                textContentType = .emailAddress
            case .password:
                textContentType = .password
                isSecureTextEntry = true
            default:
                return
            }
        }

        private func setPlaceholder() {
            switch type {
            case .username:
                placeholder = String.emailPlaceholder
            case .password:
                placeholder = String.passwordPlaceholder
            case .default:
                return
            }
        }

        private func setBorder() {
            layer.borderWidth = self.isEditing ? 1 : 0
        }

    }

}
