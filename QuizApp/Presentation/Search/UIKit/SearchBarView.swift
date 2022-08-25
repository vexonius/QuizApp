import UIKit

class SearchBarView: UIView {

    private struct CustomConstants {
        static let searchButtonTrailingInset = 20
    }

    private(set) var inputLabel: RoundedTextInput!
    private(set) var searchButton: UIButton!

    init() {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }

}

extension SearchBarView: ConstructViewsProtocol {

    func createViews() {
        inputLabel = RoundedTextInput(type: .default)
        addSubview(inputLabel)

        searchButton = UIButton()
        addSubview(searchButton)
    }

    func styleViews() {
        inputLabel.placeholder = LocalizedStrings.typeHere.localizedString

        searchButton.setTitle(LocalizedStrings.search.localizedString, for: .normal)
        searchButton.backgroundColor = .clear
        searchButton.titleLabel?.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.regular.cgFloat,
            ofWeight: .bold)
    }

    func defineLayoutForViews() {
        inputLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(DesignConstants.Insets.contentInset)
            make.top.bottom.equalToSuperview()
        }

        searchButton.snp.makeConstraints { make in
            make.leading.equalTo(inputLabel.snp.trailing).offset(DesignConstants.Insets.contentInset)
            make.trailing.equalToSuperview().inset(CustomConstants.searchButtonTrailingInset)
            make.top.bottom.equalToSuperview().inset(DesignConstants.Insets.contentInset)
        }
    }

}
