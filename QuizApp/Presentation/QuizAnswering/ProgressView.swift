import UIKit

class ProgressView: UIView {

    private struct CustomConstants {
        static let progressLabelHeight = 26
        static let textNumberOfLines = 0
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

    func update(progress: [Bool] = [true, false, true, true]) {
        for item in progress {
            debugPrint(item)
            let cell = UIView()
            cell.backgroundColor = .accentGreen
            cell.layer.cornerRadius = 2

            stackView.addArrangedSubview(cell)
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
        progressLabel.text = "0/0"
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
