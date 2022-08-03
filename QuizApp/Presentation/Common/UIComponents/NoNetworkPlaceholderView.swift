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

    private var icon: UIImageView!
    private var titleView: UILabel!
    private var errorDescriptionView: UILabel!

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
        icon = UIImageView()
        addSubview(icon)

        titleView = UILabel()
        addSubview(titleView)

        errorDescriptionView = UILabel()
        addSubview(errorDescriptionView)
    }

    func styleViews() {
        icon.image = UIImage.error

        titleView.font = UIFont.sourceSansPro(ofSize: CustomConstants.titleFontSize.cgFloat, ofWeight: .bold)
        titleView.textAlignment = .center

        errorDescriptionView.textAlignment = .center
        errorDescriptionView.numberOfLines = CustomConstants.descriptionNumberOfLines
        errorDescriptionView.font = UIFont.sourceSansPro(
            ofSize: CustomConstants.descriptionFontSize.cgFloat,
            ofWeight: .regular)
    }

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
