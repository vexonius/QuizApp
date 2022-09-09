import UIKit

class ClearSegmentedControl: UISegmentedControl {

    private struct CustomConstants {
        static let backgroundTintImageHeight = 32
        static let backgroundTintImageWidth = 1
        static let defaultSelectedIndex = 0
        static let selectedSegmentIndexKey = "selectedSegmentIndex"
    }

    private var models: [CategoryFilter] = []

    init() {
        super.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var tintColor: UIColor? {
        didSet {
            setTitleTextAttributes([
                .foregroundColor: tintColor ?? UIColor.whiteTransparent30,
                NSAttributedString.Key.font: UIFont.sourceSansPro(
                    ofSize: DesignConstants.FontSize.subtitle.cgFloat,
                    ofWeight: .semibold)!
                ],
                for: .normal)
        }
    }

    override func didChangeValue(forKey key: String) {
        super.didChangeValue(forKey: key)

        if key == CustomConstants.selectedSegmentIndexKey {
            guard !models.isEmpty else { return }

            setTitleTextAttributes([
                .foregroundColor: models[selectedSegmentIndex].category.uiColor,
                NSAttributedString.Key.font: UIFont.sourceSansPro(
                    ofSize: DesignConstants.FontSize.subtitle.cgFloat,
                    ofWeight: .bold)!
                ],
                for: .selected)
        }
    }

    func update(segments: [CategoryFilter]) {
        models = segments
        removeAllSegments()

        for segment in segments {
            insertSegment(withTitle: segment.title.capitalized, at: numberOfSegments, animated: false)
            style()
        }

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

        setTitleTextAttributes([
            .foregroundColor: UIColor.whiteTransparent30,
            NSAttributedString.Key.font: UIFont.sourceSansPro(
                ofSize: DesignConstants.FontSize.subtitle.cgFloat,
                ofWeight: .bold)!
            ],
            for: .normal)
    }

}
