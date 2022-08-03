import UIKit

class QuizCell: UICollectionViewCell {

    private struct CustomConstants {
        static let cornerRadius = 20
        static let textNumberOfLines = 0
        static let iconSize = 104
        static let iconCornerRadius = 15
        static let contentCornerRadius = 20
        static let backgroundTransparency = 0.2
        static let titleTopOffset = 6
        static let summaryTopOffset = 6
    }

    private var titleLabel: UILabel!
    private var summaryLabel: UILabel!
    private var icon: UIImageView!

    init(title: String, summary: String) {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()

        titleLabel.text = title
        summaryLabel.text = summary

        contentView.backgroundColor = .white.withAlphaComponent(CustomConstants.backgroundTransparency.cgFloat)
        contentView.layer.cornerRadius = CustomConstants.contentCornerRadius.cgFloat
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createTitleLabel() {
        titleLabel = UILabel()
        addSubview(titleLabel)
    }

    private func createIcon() {
        icon = UIImageView()
        addSubview(icon)
    }

    private func createSummaryLabel() {
        summaryLabel = UILabel()
        addSubview(summaryLabel)
    }

}

extension QuizCell: ConstructViewsProtocol {

    func createViews() {
        createTitleLabel()
        createSummaryLabel()
        createIcon()
    }

    func styleViews() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = CustomConstants.textNumberOfLines
        titleLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.title.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        icon.contentMode = .scaleAspectFill
        icon.image = UIImage.placeholder
        icon.clipsToBounds = true
        icon.layer.cornerRadius = CustomConstants.iconCornerRadius.cgFloat

        summaryLabel.textAlignment = .left
        summaryLabel.textColor = .white
        summaryLabel.numberOfLines = CustomConstants.textNumberOfLines
        summaryLabel.lineBreakMode = .byTruncatingTail
        summaryLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.paragraph.cgFloat,
            ofWeight: SourceSansProWeight.semibold)
    }

    func defineLayoutForViews() {
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
    }

}
