import UIKit

class DifficultyIndicator: UIView {

    struct CustomConstants {

        static let numberOfRectangles = 3
        static let defaultSpacing = 4
        static let rotationAmountDegrees = 90.0
        static let totalDegrees = 360.0
        static let xRotation = 0.0
        static let yRotation = 0.0
        static let zRotation = 1.0
        static let xTranslation = 0.0
        static let yTranslation = 0.0
        static let zTranslation = 0.0
        static let rectDiagonal = 15.0
        static let indicatorTransparency = 0.3
        static let cornerRadius = 2

    }

    private var difficulty: Difficulty
    private var accentColor: UIColor
    private let rectContainer: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)

    init(difficulty: Difficulty = .easy, accentColor: UIColor = .accentYellow) {
        self.difficulty = difficulty
        self.accentColor = accentColor

        super.init(frame: .zero)

        drawRectangles()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(difficulty: Difficulty, accentColor: UIColor) {
        self.accentColor = accentColor
        self.difficulty = difficulty

        drawRectangles()
    }

    private func drawRectangles(spacing: Int = CustomConstants.defaultSpacing) {
        self.layer.sublayers?.removeAll()
        var translate = CustomConstants.xTranslation

        for index in 0..<CustomConstants.numberOfRectangles {
            let bezierPath = UIBezierPath(
                roundedRect: rectContainer,
                cornerRadius: CustomConstants.cornerRadius.cgFloat)

            let rectangle = CAShapeLayer()
            rectangle.path = bezierPath.cgPath
            rectangle.fillColor = index >= difficulty.enumerated ?
                UIColor.white.withAlphaComponent(CustomConstants.indicatorTransparency).cgColor :
                accentColor.cgColor

            self.layer.addSublayer(rectangle)

            transform(rectangle: rectangle, translateX: translate)
            translate += CustomConstants.rectDiagonal + Double(spacing)
        }
    }

    private func transform(rectangle: CAShapeLayer, translateX: Double) {
        let degrees = CustomConstants.rotationAmountDegrees
        let radians = CGFloat(degrees * Double.pi / CustomConstants.totalDegrees)
        rectangle.transform = CATransform3DConcat(
            CATransform3DMakeRotation(
                radians,
                CustomConstants.xRotation.cgFloat,
                CustomConstants.yRotation.cgFloat,
                CustomConstants.zRotation.cgFloat),
            CATransform3DMakeTranslation(
                translateX.cgFloat,
                CustomConstants.yTranslation.cgFloat,
                CustomConstants.zTranslation.cgFloat))
    }

}
