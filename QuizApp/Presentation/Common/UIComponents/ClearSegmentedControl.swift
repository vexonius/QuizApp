import UIKit

class ClearSegmentedControll: UISegmentedControl {

    private struct CustomConstants {
        static let backgroundTintImageHeight = 32
        static let backgroundTintImageWidth = 1
        static let defaultSelectedIndex = 0
    }

    init() {
        super.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var tintColor: UIColor? {
        didSet {
            setTitleTextAttributes(
                [.foregroundColor: UIColor.whiteTransparent30,
                NSAttributedString.Key.font:
                    UIFont.sourceSansPro(ofSize: DesignConstants.FontSize.subtitle.cgFloat, ofWeight: .semibold)!],
                for: .normal)
        }
    }

    override var selectedSegmentTintColor: UIColor? {
        didSet {
            setTitleTextAttributes(
                [.foregroundColor: UIColor.white,
                NSAttributedString.Key.font:
                    UIFont.sourceSansPro(ofSize: DesignConstants.FontSize.subtitle.cgFloat, ofWeight: .semibold)!],
                for: .selected)
        }
    }

    func updateSegments(segments: [String]) {
        removeAllSegments()

        for segment in segments {
            insertSegment(withTitle: segment, at: numberOfSegments, animated: false)
        }

        style()
        selectedSegmentIndex = CustomConstants.defaultSelectedIndex
    }

    private func style() {
        backgroundColor = .clear

        let tintColorImage = UIImage(
            color: .clear,
            size: CGSize(
                width: CustomConstants.backgroundTintImageWidth,
                height: CustomConstants.backgroundTintImageHeight))

        setBackgroundImage(tintColorImage, for: .normal, barMetrics: .default)
        setDividerImage(tintColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

        setTitleTextAttributes(
            [.foregroundColor: UIColor.whiteTransparent30,
            NSAttributedString.Key.font:
                UIFont.sourceSansPro(ofSize: DesignConstants.FontSize.subtitle.cgFloat, ofWeight: .semibold)!],
            for: .normal)

        setTitleTextAttributes(
            [.foregroundColor: UIColor.white,
            NSAttributedString.Key.font:
                UIFont.sourceSansPro(ofSize: DesignConstants.FontSize.subtitle.cgFloat, ofWeight: .semibold)!],
            for: .selected)
    }

}
