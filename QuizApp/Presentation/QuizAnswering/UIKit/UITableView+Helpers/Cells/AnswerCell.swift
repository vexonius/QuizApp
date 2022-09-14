import UIKit

class AnswerCell: UITableViewCell {

    static let reuseIdentifier = String(describing: AnswerCell.self)

    private struct CustomConstants {
        static let textNumberOfLines = 0
        static let cellTopInset = 16
        static let cellBottomInset = 20
        static let cellSpacing = 8
    }

    private var containerView: UIView!
    private var answerLabel: UILabel!
    private var isCorrect: Bool?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.cornerRadius = containerView.bounds.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        guard
            selected,
            let isCorrect = isCorrect
        else { return }

        containerView.backgroundColor = isCorrect ? .accentGreen : .accentRed
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
        containerView.backgroundColor = .white30

        answerLabel.textAlignment = .left
        answerLabel.textColor = .white
        answerLabel.lineBreakMode = .byTruncatingTail
        answerLabel.numberOfLines = CustomConstants.textNumberOfLines
        answerLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.subtitle.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        selectionStyle = .none
        backgroundColor = .clear
    }

    func defineLayoutForViews() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.top.bottom.equalToSuperview().inset(CustomConstants.cellSpacing)
        }

        answerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(DesignConstants.Insets.componentsInset)
            make.top.equalToSuperview().inset(CustomConstants.cellTopInset)
            make.bottom.equalToSuperview().inset(CustomConstants.cellBottomInset)
        }
    }

}

extension AnswerCell {

    func bind(with model: AnswerCellModel) {
        answerLabel.text = model.answerText
        isCorrect = model.isCorrect
        containerView.backgroundColor = .white30
    }

}
