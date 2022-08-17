import UIKit

class AnswerCell: UITableViewCell {

    static let reuseIdentifier = String(describing: AnswerCell.self)

    private struct CustomConstants {
        static let textNumberOfLines = 0
    }

    private var containerView: UIView!
    private var answerLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AnswerCell: ConstructViewsProtocol {

    func createViews() {
        containerView = UIView()
        addSubview(containerView)

        answerLabel = UILabel()
        containerView.addSubview(answerLabel)
    }

    func styleViews() {
        answerLabel.textAlignment = .left
        answerLabel.textColor = .white
        answerLabel.lineBreakMode = .byTruncatingTail
        answerLabel.numberOfLines = CustomConstants.textNumberOfLines
        answerLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.subtitle.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        selectionStyle = .default
        backgroundColor = .whiteTransparent30
    }

    func defineLayoutForViews() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        answerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.componentsInset)
        }
    }

}
