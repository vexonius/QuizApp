import UIKit

class PopGradient: CAGradientLayer {

    private let gradientStartPoint = CGPoint(x: 0.5, y: 1)
    private let gradientEndPoint = CGPoint(x: 0.5, y: 0)

    override init() {
        super.init()

        colors = [UIColor.darkerPurple.cgColor, UIColor.lighterPurple.cgColor]
        type = .axial
        startPoint = gradientStartPoint
        endPoint = gradientEndPoint
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
