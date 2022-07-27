import Foundation
import UIKit
import SnapKit

class Snackbar: UIView {

    private struct CustomConstants {
        static let fontSize: CGFloat = 18
        static let numberOfLines = 0
        static let regularComponentHeight = 100
        static let horizontalComponentHeight = 60
        static let animationDuration = 0.6
        static let animationDelay = 0.0
        static let animationSpringDamping = 0.9
        static let animationInitialSpringVelocity = 0.7
        static let messageDuration = 3
        static let messageOffset = 8
    }

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sourceSansPro(ofSize: CustomConstants.fontSize, ofWeight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = CustomConstants.numberOfLines
        label.textColor = .white

        return label
    }()

    private let contextView: UIView
    private var height: CGFloat = CustomConstants.regularComponentHeight.cgFloat
    private let message: String

    init(in contextView: UIView, message: String) {
        self.contextView = contextView
        self.message = message

        super.init(frame: .zero)

        createViews()
        defineLayoutForViews()
        styleViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        superview?.layoutIfNeeded()
        adaptComponentsForOrientationChanges()

        UIView.animate(
            withDuration: CustomConstants.animationDuration,
            delay: CustomConstants.animationDelay,
            usingSpringWithDamping: CustomConstants.animationSpringDamping,
            initialSpringVelocity: CustomConstants.animationInitialSpringVelocity,
            options: .curveEaseOut,
            animations: {
                self.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview()
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(self.height)
                }

                self.superview?.layoutIfNeeded()
            },
            completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + CustomConstants.messageDuration.cgFloat) {
                    if self.superview != nil {
                        self.dismiss()
                    }
                }
            })
    }

    func dismiss() {
        superview?.layoutIfNeeded()

        UIView.animate(
            withDuration: CustomConstants.animationDuration,
            delay: CustomConstants.animationDelay,
            usingSpringWithDamping: CustomConstants.animationSpringDamping,
            initialSpringVelocity: CustomConstants.animationInitialSpringVelocity,
            options: .curveEaseOut,
            animations: {
                self.snp.remakeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(self.height)
                    make.top.equalTo(self.contextView.snp.bottom)
                }

                self.superview?.layoutIfNeeded()
            }, completion: { _ in
                self.removeFromSuperview()
            })
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        adaptComponentsForOrientationChanges()
        updateLayoutConstraints()
    }

    private func adaptComponentsForOrientationChanges() {
        height = superview?.traitCollection.verticalSizeClass == .regular ?
            CustomConstants.regularComponentHeight.cgFloat + contextView.safeAreaInsets.bottom :
            CustomConstants.horizontalComponentHeight.cgFloat + contextView.safeAreaInsets.bottom

        messageLabel.text = superview?.traitCollection.verticalSizeClass == .regular ?
            message :
            message.replacingOccurrences(of: "\n", with: "")
    }

    private func updateLayoutConstraints() {
        superview?.layoutIfNeeded()

        UIView.animate(
            withDuration: CustomConstants.animationDuration,
            delay: CustomConstants.animationDelay,
            usingSpringWithDamping: CustomConstants.animationSpringDamping,
            initialSpringVelocity: CustomConstants.animationInitialSpringVelocity,
            options: .curveEaseOut,
            animations: {
                self.snp.remakeConstraints { make in
                    make.bottom.equalToSuperview()
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(self.height)
                }

                self.superview?.layoutIfNeeded()
            })
    }

    private func constraintSuperView(with view: UIView) {
        view.addSubview(self)

        self.snp.makeConstraints { make in
            make.top.equalTo(contextView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }

        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contextView.safeAreaInsets)
            make.top.equalToSuperview().offset(CustomConstants.messageOffset)
        }
    }

    private func removeOldViews(form view: UIView) {
        view.subviews
            .filter { $0 is Self }
            .forEach { $0.removeFromSuperview() }
    }

}

extension Snackbar: ConstructViewsProtocol {

    func createViews() {
        removeOldViews(form: contextView)
    }

    func styleViews() {
        messageLabel.text = message
        backgroundColor = .systemGray6
    }

    func defineLayoutForViews() {
        constraintSuperView(with: contextView)
    }

}
