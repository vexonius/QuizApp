import UIKit

class HeaderView: UIView {

    private var playerLabel: UILabel!
    private var pointsLabel: UILabel!

    init() {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HeaderView: ConstructViewsProtocol {

    func createViews() {
        playerLabel = UILabel()
        addSubview(playerLabel)

        pointsLabel = UILabel()
        addSubview(pointsLabel)
    }

    func styleViews() {
        playerLabel.textAlignment = .left
        playerLabel.textColor = .whiteTransparent30
        playerLabel.lineBreakMode = .byTruncatingTail
        playerLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.regular.cgFloat,
            ofWeight: SourceSansProWeight.semibold)
        playerLabel.text = LocalizedStrings.player.localizedString

        pointsLabel.textAlignment = .right
        pointsLabel.textColor = .whiteTransparent30
        pointsLabel.lineBreakMode = .byTruncatingTail
        pointsLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.regular.cgFloat,
            ofWeight: SourceSansProWeight.semibold)
        pointsLabel.text = LocalizedStrings.points.localizedString
    }

    func defineLayoutForViews() {
        playerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.top.bottom.equalToSuperview()
        }

        pointsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.top.bottom.equalToSuperview()
        }
    }

}
