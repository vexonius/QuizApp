import UIKit
import Nuke

class QuizCell: UITableViewCell {

    static let reuseIdentifier = String(describing: QuizCell.self)

    private struct CustomConstants {
        static let cornerRadius = 20
        static let textNumberOfLines = 0
        static let iconSize = 104
        static let iconCornerRadius = 15
        static let contentCornerRadius = 20
        static let backgroundTransparency = 0.2
        static let titleTopOffset = 6
        static let summaryTopOffset = 6
        static let difficultyIndicatorTrailingInset = 18
        static let difficultyIndicatorTopOffset = 12
        static let difficultyIndicatorWidth = 48
    }

    private var containerView: UIView!
    private var titleLabel: UILabel!
    private var summaryLabel: UILabel!
    private var icon: UIImageView!
    private var difficultyIndicator: DifficultyIndicator!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createTitleLabel() {
        titleLabel = UILabel()
        containerView.addSubview(titleLabel)
    }

    private func createIcon() {
        icon = UIImageView()
        containerView.addSubview(icon)
    }

    private func createSummaryLabel() {
        summaryLabel = UILabel()
        containerView.addSubview(summaryLabel)
    }

    private func createDifficultyIndicator() {
        difficultyIndicator = DifficultyIndicator(difficulty: .normal)
        containerView.addSubview(difficultyIndicator)
    }

    private func createContainerView() {
        containerView = UIView()
        addSubview(containerView)
    }

}

extension QuizCell: ConstructViewsProtocol {

    func createViews() {
        createContainerView()
        createTitleLabel()
        createSummaryLabel()
        createIcon()
        createDifficultyIndicator()
    }

    func styleViews() {
        containerView.backgroundColor = .white.withAlphaComponent(CustomConstants.backgroundTransparency.cgFloat)
        containerView.layer.cornerRadius = CustomConstants.contentCornerRadius.cgFloat

        icon.contentMode = .scaleAspectFill
        icon.clipsToBounds = true
        icon.layer.cornerRadius = CustomConstants.iconCornerRadius.cgFloat

        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = CustomConstants.textNumberOfLines
        titleLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.title.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        summaryLabel.textAlignment = .left
        summaryLabel.textColor = .white
        summaryLabel.numberOfLines = CustomConstants.textNumberOfLines
        summaryLabel.lineBreakMode = .byTruncatingTail
        summaryLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.regular.cgFloat,
            ofWeight: SourceSansProWeight.semibold)
    }

    func defineLayoutForViews() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(DesignConstants.Insets.contentInset)
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(5)
        }

        icon.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.size.equalTo(CustomConstants.iconSize)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(DesignConstants.Insets.contentInset)
            make.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.top.equalTo(icon).offset(CustomConstants.titleTopOffset)
        }

        summaryLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(DesignConstants.Insets.contentInset)
            make.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.top.equalTo(titleLabel.snp.bottom).offset(CustomConstants.summaryTopOffset)
            make.bottom.lessThanOrEqualTo(icon)
        }

        difficultyIndicator.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(CustomConstants.difficultyIndicatorTrailingInset)
            make.top.equalToSuperview().offset(CustomConstants.difficultyIndicatorTopOffset)
            make.width.equalTo(CustomConstants.difficultyIndicatorWidth)
        }
    }

}

extension QuizCell {

    func bind(with model: QuizCellModel) {
        titleLabel.text = model.name
        summaryLabel.text = model.description
        difficultyIndicator.update(difficulty: model.difficulty, accentColor: model.category.color)

        if let url = URL(string: model.imageUrl) {
            Nuke.loadImage(with: url, into: icon)
        }

        if let highlightedText = model.highlightedText {
            titleLabel.highlight(target: highlightedText)
        }
    }

}
