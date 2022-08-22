import Combine
import UIKit

extension UITextField {

    var textDidChange: AnyPublisher<String, Never> {
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }

    var textDidBeginEditing: AnyPublisher<UITextField?, Never> {
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidBeginEditingNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .eraseToAnyPublisher()
    }

    var textDidEndEditing: AnyPublisher<UITextField?, Never> {
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidEndEditingNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .eraseToAnyPublisher()
    }

}

extension UILabel {

    func highlight(text: String?, color: UIColor? = .whiteTransparent30) {
        guard
            let fullText = self.text,
            let target = text
        else { return }

        let attributedText = NSMutableAttributedString(string: fullText)
        let range: NSRange = attributedText.mutableString.range(of: target, options: .caseInsensitive)

        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.backgroundColor] = color
        attributedText.addAttributes(attributes, range: range)

        self.attributedText = attributedText
    }

}
