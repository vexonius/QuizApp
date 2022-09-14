import Foundation
import CoreGraphics

struct DesignConstants {

    struct Insets {
        static let none = 0

        static let componentsInset: Float = 32.0
        static let inputComponentEditRectTopInset: Float = 10
        static let inputComponentEditRectRightInset: Float = 21
        static let inputComponentEditRectLeftInset: Float = 21
        static let inputComponentEditRectBottomInset: Float = 10
        static let thumbnailRightInset: Float = 18
        static let componentSpacing: Float = 16
        static let contentInset: Float = 20
        static let textSpacing: Float = 8
    }

    struct InputComponents {
        static let height: Float = 44.0
        static let cornerRadius: Float = 22
        static let borderWidth = 1
        static let noBorder = 0
        static let thumbnailWidth = 20
        static let thumbnailHeight = 20
        static let thumbnailInset = 20
        static let thumbnailPadding = 44
    }

    struct Label {
        static let headingHeight = 40
        static let subtitleHeight = 24
    }

    struct FontSize {
        static let paragraph: Float = 14
        static let regular: Float = 16
        static let subtitle: Float = 20
        static let title: Float = 24
        static let heading: Float = 32
    }

    struct Decorator {
        static let cornerSize: Float = 20
    }

    struct ControlComponents {
        static let segmentedControlHeight: Float = 32
    }

    struct QuizCell {
        static let height = 154
    }

    struct Padding {
        static let base: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 32
    }

}
