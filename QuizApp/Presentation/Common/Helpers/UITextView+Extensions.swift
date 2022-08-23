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
