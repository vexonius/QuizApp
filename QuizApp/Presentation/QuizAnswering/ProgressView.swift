import UIKit

class ProgressView: UIView {

    private struct CustomConstants {
        static let progressLabelHeight = 26
        static let textNumberOfLines = 0
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
        _ = stackView.arrangedSubviews.map { $0.removeFromSuperview() }

        for (index, tile) in tiles.enumerated() {
            let view = UIView()

            switch tile {
            case .unanswered:
                view.backgroundColor = currentIndex == index ? .white : .whiteTransparent30
            case .correct:
                view.backgroundColor = .accentGreen
            case .false:
                view.backgroundColor = .accentRed
            }

            view.layer.cornerRadius = 2
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

        stackView.spacing = 8
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
            make.top.equalTo(progressLabel.snp.bottom).offset(DesignConstants.Insets.componentSpacing)
            make.height.equalTo(5)
        }
    }

}
