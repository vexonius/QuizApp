import Combine
import UIKit
import Nuke

class QuizDetailsViewController: BaseViewController {

    private struct CustomConstants {
        static let preferredContainerVerticalHeight = 600
        static let containerVerticalInset = 40
        static let preferredContainerHorizontalWidth = 400
        static let preferredCoverHeight = 200
        static let leaderOffset = 10
        static let maxSubtitleLabelHeight = 80
        static let subtitleNumberOfLines = 80
    }

    private var containerView: UIView!
    private var componentsStackView: UIStackView!
    private var leaderBoardLabel: UILabel!
    private var titleLabel: UILabel!
    private var summaryLabel: UILabel!
    private var cover: UIImageView!
    private var startQuizButton: RoundedButton!

    private let placeHolderImage = UIImage.init(color: .whiteTransparent30, size: CGSize(width: 400, height: 400))

    private var cancellables: Set<AnyCancellable> = []

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        styleNavigationBar()
        defineLayoutForViews()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()

        adaptContainerViewForTaitCollectionChanges()
    }

    private func adaptContainerViewForTaitCollectionChanges() {
        containerView.snp.remakeConstraints { make in
            if view.traitCollection.verticalSizeClass == .regular {
                make.height.lessThanOrEqualTo(CustomConstants.preferredContainerVerticalHeight)
                make.width.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.contentInset)
                make.center.equalToSuperview()
            } else {
                make.height.equalToSuperview().inset(CustomConstants.containerVerticalInset)
                make.width.equalTo(CustomConstants.preferredContainerHorizontalWidth)
                make.bottom.equalToSuperview().inset(DesignConstants.Insets.componentSpacing)
            }

            make.centerX.equalToSuperview()
            make.top.equalTo(leaderBoardLabel.snp.bottom)
        }
    }

    private func styleNavigationBar() {
        title = LocalizedStrings.appName.localizedString
    }
}
extension QuizDetailsViewController: ConstructViewsProtocol {

    func createViews() {
        leaderBoardLabel = UILabel()
        view.addSubview(leaderBoardLabel)

        containerView = UIView()
        view.addSubview(containerView)

        componentsStackView = UIStackView()
        containerView.addSubview(componentsStackView)

        titleLabel = UILabel()
        componentsStackView.addArrangedSubview(titleLabel)

        summaryLabel = UILabel()
        componentsStackView.addArrangedSubview(summaryLabel)

        cover = UIImageView()
        componentsStackView.addArrangedSubview(cover)

        startQuizButton = RoundedButton(with: LocalizedStrings.startQuizTitle.localizedString)
        componentsStackView.addArrangedSubview(startQuizButton)
    }

    func styleViews() {
        containerView.backgroundColor = .whiteTransparent30
        containerView.layer.cornerRadius = DesignConstants.Decorator.cornerSize.cgFloat

        leaderBoardLabel.textAlignment = .right
        leaderBoardLabel.textColor = .white
        leaderBoardLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.subtitle.cgFloat,
            ofWeight: SourceSansProWeight.semibold)
        leaderBoardLabel.attributedText = NSAttributedString(
            string: LocalizedStrings.leaderboard.localizedString,
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])

        titleLabel.text = LocalizedStrings.appName.localizedString
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.heading.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        summaryLabel.text = LocalizedStrings.placeholderText.localizedString
        summaryLabel.textAlignment = .center
        summaryLabel.textColor = .white
        summaryLabel.numberOfLines = CustomConstants.subtitleNumberOfLines
        summaryLabel.lineBreakMode = .byTruncatingTail
        summaryLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.subtitle.cgFloat,
            ofWeight: SourceSansProWeight.semibold)

        cover.image = placeHolderImage
        cover.clipsToBounds = true
        cover.layer.cornerRadius = DesignConstants.Decorator.cornerSize.cgFloat

        componentsStackView.spacing = DesignConstants.Insets.componentSpacing.cgFloat
        componentsStackView.axis = .vertical
        componentsStackView.alignment = .center
        componentsStackView.distribution = .equalSpacing
    }

    func defineLayoutForViews() {
        leaderBoardLabel.snp.makeConstraints { make in
            make.trailing.equalTo(containerView)
            make.height.equalTo(DesignConstants.Label.headingHeight)
        }

        containerView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.contentInset)
            make.height.lessThanOrEqualTo(CustomConstants.preferredContainerVerticalHeight)
            make.center.equalToSuperview()
        }

        componentsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(DesignConstants.Insets.contentInset)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.height.equalTo(DesignConstants.Label.headingHeight)
        }

        summaryLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.height.greaterThanOrEqualTo(DesignConstants.Label.subtitleHeight)
            make.height.lessThanOrEqualTo(CustomConstants.maxSubtitleLabelHeight)
        }

        cover.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.height.lessThanOrEqualTo(CustomConstants.preferredCoverHeight)
        }

        startQuizButton.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.height.equalTo(DesignConstants.InputComponents.height)
        }
    }

}
