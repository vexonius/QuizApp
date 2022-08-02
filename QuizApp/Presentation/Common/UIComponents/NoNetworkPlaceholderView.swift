import SnapKit
import UIKit

class ErrorPlaceholderView: UIView {

    private struct CustomConstants {
        static let titleFontSize: Float = 28
        static let descriptionFontSize: Float = 16
        static let descriptionNumberOfLines = 0
        static let iconSize: Float = 68
    }

    var title: String? {
        didSet {
            titleView.text = title
        }
    }

    var errorDescription: String? {
        didSet {
            errorDescriptionView.text = errorDescription
        }
    }

    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.error

        return imageView
    }()

    private lazy var titleView: UILabel = {
        let title = UILabel()
        title.font = UIFont.sourceSansPro(ofSize: CustomConstants.titleFontSize.cgFloat, ofWeight: .bold)
        title.textAlignment = .center

        return title
    }()

    private lazy var errorDescriptionView: UILabel = {
        let description = UILabel()
        description.font = UIFont.sourceSansPro(ofSize: CustomConstants.descriptionFontSize.cgFloat, ofWeight: .regular)
        description.textAlignment = .center
        description.numberOfLines = CustomConstants.descriptionNumberOfLines

        return description
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ErrorPlaceholderView: ConstructViewsProtocol {

    func createViews() {
        addSubview(icon)
        addSubview(titleView)
        addSubview(errorDescriptionView)
    }

    func styleViews() {}

    func defineLayoutForViews() {
        titleView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }

        icon.snp.makeConstraints { make in
            make.height.width.equalTo(CustomConstants.iconSize)
            make.bottom.equalTo(titleView.snp.top).offset(-DesignConstants.Insets.componentSpacing)
            make.centerX.equalToSuperview()
        }

        errorDescriptionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(titleView.snp.bottom).offset(DesignConstants.Insets.textSpacing)
            make.centerX.equalToSuperview()
        }
    }

}
