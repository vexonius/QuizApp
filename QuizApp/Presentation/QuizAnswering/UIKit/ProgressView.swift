import UIKit

class ProgressView: UIView {

    private struct CustomConstants {
        static let progressLabelHeight = 26
        static let textNumberOfLines = 0
        static let progressBarHeight = 5
        static let tileCornerRadius = 2
        static let stackViewSpacing = 8
        static let componentsSpacing = 12
    }

    var progressText: String? {
        didSet {
            progressLabel.text = progressText
        }
    }

    private var progressLabel: UILabel!
    private var stackView: UIStackView!

    init() {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(currentIndex: Int, tiles: [AnsweredResult]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for (index, tile) in tiles.enumerated() {
            let view = UIView()

            switch tile {
            case .unanswered:
                view.backgroundColor = currentIndex == index ? .white : .whiteTransparent30
            case .correct:
                view.backgroundColor = .accentGreen
            case .incorrect:
                view.backgroundColor = .accentRed
            }

            view.layer.cornerRadius = CustomConstants.tileCornerRadius.cgFloat
            stackView.addArrangedSubview(view)
        }
    }

}

extension ProgressView: ConstructViewsProtocol {

    func createViews() {
        progressLabel = UILabel()
        addSubview(progressLabel)

        stackView = UIStackView()
        addSubview(stackView)
    }

    func styleViews() {
        progressLabel.textAlignment = .left
        progressLabel.textColor = .white
        progressLabel.lineBreakMode = .byTruncatingTail
        progressLabel.numberOfLines = CustomConstants.textNumberOfLines
        progressLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.subtitle.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        stackView.spacing = CustomConstants.componentsSpacing.cgFloat
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
    }

    func defineLayoutForViews() {
        progressLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(CustomConstants.progressLabelHeight)
        }

        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(progressLabel.snp.bottom).offset(CustomConstants.componentsSpacing)
            make.height.equalTo(CustomConstants.progressBarHeight)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }

}
