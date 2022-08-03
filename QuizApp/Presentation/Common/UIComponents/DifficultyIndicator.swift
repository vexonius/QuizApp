import UIKit

class DifficultyIndicator: UIView {

    struct CustomConstants {
        static let numberOfRectangles = 3
        static let defaultSpacing = 4
        static let rotationAmoutDegrees = 90.0
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

    enum Difficulty: Int {

        case easy = 1
        case normal = 2
        case hard = 3

    }

    private let difficulty: Difficulty
    private let rectContainer: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)

    init(difficulty: Difficulty = .easy) {
        self.difficulty = difficulty

        super.init(frame: .zero)

        drawRectangles()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawRectangles(spacing: Int = CustomConstants.defaultSpacing) {
        var translate = CustomConstants.xTranslation

        for index in 1...CustomConstants.numberOfRectangles {
            let bezierPath = UIBezierPath(
                roundedRect: rectContainer,
                cornerRadius: CustomConstants.cornerRadius.cgFloat)

            let rectangle = CAShapeLayer()
            rectangle.path = bezierPath.cgPath
            rectangle.fillColor = index >= difficulty.rawValue ?
                UIColor.white.withAlphaComponent(CustomConstants.indicatorTransparency).cgColor :
                UIColor.accentRed.cgColor

            self.layer.addSublayer(rectangle)

            transform(rectangle: rectangle, translateX: translate)
            translate += CustomConstants.rectDiagonal + Double(spacing)
        }
    }

    private func transform(rectangle: CAShapeLayer, translateX: Double) {
        let degrees = CustomConstants.rotationAmoutDegrees
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
