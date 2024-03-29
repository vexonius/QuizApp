import UIKit

class RankingCell: UITableViewCell {

    static let reuseIdentifier = String(describing: RankingCell.self)

    private struct CustomConstants {

        static let textNumberOfLines = 0

    }

    private var containerView: UIView!
    private var rankLabel: UILabel!
    private var userLabel: UILabel!
    private var pointsLabel: UILabel!

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

}

extension RankingCell: ConstructViewsProtocol {

    func createViews() {
        containerView = UIView()
        addSubview(containerView)

        userLabel = UILabel()
        containerView.addSubview(userLabel)

        rankLabel = UILabel()
        containerView.addSubview(rankLabel)

        pointsLabel = UILabel()
        containerView.addSubview(pointsLabel)
    }

    func styleViews() {
        rankLabel.textAlignment = .right
        rankLabel.textColor = .white
        rankLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.title.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        userLabel.textAlignment = .left
        userLabel.textColor = .white
        userLabel.lineBreakMode = .byTruncatingTail
        userLabel.numberOfLines = CustomConstants.textNumberOfLines
        userLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.subtitle.cgFloat,
            ofWeight: SourceSansProWeight.semibold)

        pointsLabel.textAlignment = .left
        pointsLabel.textColor = .white
        pointsLabel.lineBreakMode = .byTruncatingTail
        pointsLabel.numberOfLines = CustomConstants.textNumberOfLines
        pointsLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.title.cgFloat,
            ofWeight: SourceSansProWeight.bold)
    }

    func defineLayoutForViews() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        rankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        userLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing).offset(DesignConstants.Insets.contentInset)
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(userLabel.snp.trailing).offset(DesignConstants.Insets.contentInset)
        }
    }

}

extension RankingCell {

    func bind(with model: UserRankingCellModel) {
        rankLabel.text = model.position
        userLabel.text = model.name
        pointsLabel.text = String(model.points)
    }

}
