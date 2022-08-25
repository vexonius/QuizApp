import Foundation
import UIKit

class RoundedTextInput: UITextField {

    enum RoundedTextInputType {
        case username
        case password
        case `default`
    }

    private enum RoundedTextInputAttributes: String {
        case placeholderText = "placeholder text"
    }

    private var type: RoundedTextInputType = .default
    private let containerPadding = UIEdgeInsets(top: 10, left: 21, bottom: 10, right: 40)

    init(type: RoundedTextInputType) {
        super.init(frame: .zero)

        self.type = type

        style()
        setContentType()
        setBorder()
        setPlaceholder()
        setImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: containerPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: containerPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: containerPadding)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= DesignConstants.Insets.thumbnailRightInset.cgFloat

        return rightViewRect
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = self.bounds.height / 2.0
    }

    func styleForInFocus() {
        layer.borderWidth = DesignConstants.InputComponents.borderWidth.cgFloat
    }

    func styleForOutOfFocus() {
        layer.borderWidth = DesignConstants.InputComponents.noBorder.cgFloat
    }

    private func style() {
        backgroundColor = .textFieldBackground
        tintColor = .white
        textColor = .white

        layer.borderColor = UIColor.white.cgColor
        layer.cornerCurve = .continuous

        attributedPlaceholder = NSAttributedString(
            string: RoundedTextInputAttributes.placeholderText.rawValue,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        font = self.isFocused ?
            .sourceSansPro(ofSize: DesignConstants.FontSize.regular.cgFloat, ofWeight: .regular) :
            .sourceSansPro(ofSize: DesignConstants.FontSize.regular.cgFloat, ofWeight: .semibold)
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
            placeholder = LocalizedStrings.emailPlaceholder.localizedString
        case .password:
            placeholder = LocalizedStrings.passwordPlaceholder.localizedString
        case .default:
            return
        }
    }

    private func setBorder() {
        layer.borderWidth = self.isEditing ?
            DesignConstants.InputComponents.borderWidth.cgFloat :
            DesignConstants.InputComponents.noBorder.cgFloat
    }

    private func setImage() {
        guard type == .password else { return }

        self.rightView = UIImageView(image: .hideText)
        self.rightView?.isUserInteractionEnabled = true
        self.rightViewMode = .always
        self.rightView?.frame = CGRect(
            x: .zero,
            y: .zero,
            width: DesignConstants.InputComponents.thumbnailWidth,
            height: DesignConstants.InputComponents.thumbnailHeight)
    }

}
