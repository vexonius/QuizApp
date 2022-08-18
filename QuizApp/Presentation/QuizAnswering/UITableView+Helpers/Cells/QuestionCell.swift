import UIKit

class QuestionCell: UITableViewCell {

    static let reuseIdentifier = String(describing: QuestionCell.self)

    private struct CustomConstants {
        static let textNumberOfLines = 0
    }

    private var containerView: UIView!
    private var questionLabel: UILabel!

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

extension QuestionCell: ConstructViewsProtocol {

    func createViews() {
        containerView = UIView()
        addSubview(containerView)

        questionLabel = UILabel()
        containerView.addSubview(questionLabel)
    }

    func styleViews() {
        questionLabel.textAlignment = .left
        questionLabel.textColor = .white
        questionLabel.lineBreakMode = .byTruncatingTail
        questionLabel.numberOfLines = CustomConstants.textNumberOfLines
        questionLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.subtitle.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        selectionStyle = .none
        backgroundColor = .clear
        isUserInteractionEnabled = false
    }

    func defineLayoutForViews() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        questionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(DesignConstants.Insets.contentInset)
        }
    }

}

extension QuestionCell {

    func bind(with model: QuestionCellModel) {
        questionLabel.text = model.questionText
    }

}
