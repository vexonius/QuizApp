import UIKit

extension UILabel {

    func highlight(target text: String, with color: UIColor? = .white30) {
        guard let labelText = self.text else { return }

        let attributedText = NSMutableAttributedString(string: labelText)
        let range: NSRange = attributedText.mutableString.range(of: text, options: .caseInsensitive)

        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[.backgroundColor] = color
        attributedText.addAttributes(attributes, range: range)

        self.attributedText = attributedText
    }

}
