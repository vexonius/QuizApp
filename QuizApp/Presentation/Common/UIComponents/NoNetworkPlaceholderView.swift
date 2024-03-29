import SnapKit
import UIKit

class ErrorPlaceholderView: UIView {

    private struct CustomConstants {

        static let titleFontSize: Float = 28
        static let descriptionFontSize: Float = 16
        static let descriptionNumberOfLines = 0
        static let iconSize: Float = 68

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

        titleView.text = LocalizedStrings.error.localizedString
        titleView.font = UIFont.sourceSansPro(ofSize: CustomConstants.titleFontSize.cgFloat, ofWeight: .bold)
        titleView.textAlignment = .center

        errorDescriptionView.textAlignment = .center
        errorDescriptionView.numberOfLines = CustomConstants.descriptionNumberOfLines
        errorDescriptionView.font = UIFont.sourceSansPro(
            ofSize: CustomConstants.descriptionFontSize.cgFloat,
            ofWeight: .regular)
    }

    func defineLayoutForViews() {
        icon.snp.makeConstraints { make in
            make.height.width.equalTo(CustomConstants.iconSize)
            make.centerX.equalToSuperview()
        }

        titleView.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(DesignConstants.Insets.componentSpacing)
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }

        errorDescriptionView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(DesignConstants.Insets.textSpacing)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }

}
