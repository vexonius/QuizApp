import UIKit

class AnswerCell: UITableViewCell {

    static let reuseIdentifier = String(describing: AnswerCell.self)

    private struct CustomConstants {
        static let textNumberOfLines = 0
        static let cellTopInset = 16
        static let cellBottomInset = 20
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
        containerView.layer.cornerRadius = containerView.bounds.height / 2
        containerView.backgroundColor = .whiteTransparent30

        answerLabel.textAlignment = .left
        answerLabel.textColor = .white
        answerLabel.lineBreakMode = .byTruncatingTail
        answerLabel.numberOfLines = CustomConstants.textNumberOfLines
        answerLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.subtitle.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        selectionStyle = .default
        backgroundColor = .clear
    }

    func defineLayoutForViews() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        answerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.componentsInset)
            make.top.equalToSuperview().inset(CustomConstants.cellTopInset)
            make.bottom.equalToSuperview().inset(CustomConstants.cellBottomInset)
        }
    }

}
