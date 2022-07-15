import Foundation
import UIKit

class RoundedButton: UIButton {

    private var buttonTitle: String

    init(with buttonTitle: String = "") {
        self.buttonTitle = buttonTitle

        super.init(frame: .zero)

        setTitle(buttonTitle, for: .normal)
        style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func style() {
        backgroundColor = .white
        setTitleColor(.darkerPurple, for: .normal)
        layer.cornerRadius = DesignConstants.InputComponents.cornerRadius.cgFloat
        layer.cornerCurve = .continuous

        if let titleLabel = titleLabel {
            titleLabel.font = .sourceSansPro(
                ofSize: DesignConstants.FontSize.regular.cgFloat,
                ofWeight: .bold)
        }
    }

}
