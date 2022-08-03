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
        static let revealAnimationDuration = 0.4
        static let revealAnimationDelay = 0.15
        static let animationSpringDamping = 0.9
        static let animationInitialSpringVelocity = 0.7
        static let messageDuration = 3
        static let messageOffset = 8
        static let alphaValueTransparent = 0.0
        static let alphaValueVisible = 1.0
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
    private let message: String
    private var height: CGFloat = CustomConstants.regularComponentHeight.cgFloat

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

        adaptToOrientationChanges()
        updateMessageLabelConstraintsForDismiss()

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

        UIView.animate(
            withDuration: CustomConstants.revealAnimationDuration,
            delay: CustomConstants.revealAnimationDelay
        ) {
            self.messageLabel.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(self.contextView.safeAreaLayoutGuide)
            }

            self.messageLabel.alpha = CustomConstants.alphaValueVisible
        }
    }

    func dismiss() {
        superview?.layoutIfNeeded()
        updateMessageLabelConstraintsForDismiss()

        UIView.animate(
            withDuration: CustomConstants.animationDuration,
            delay: CustomConstants.animationDelay,
            usingSpringWithDamping: CustomConstants.animationSpringDamping,
            initialSpringVelocity: CustomConstants.animationInitialSpringVelocity,
            options: .curveEaseOut,
            animations: {
                self.messageLabel.alpha = CustomConstants.alphaValueTransparent.cgFloat
                self.updateConstraintsForDissmis()
                self.superview?.layoutIfNeeded()
            }, completion: { _ in
                self.removeFromSuperview()
            })
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        adaptToOrientationChanges()
        updateLayoutConstraints()
    }

    private func adaptToOrientationChanges() {
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
                self.updateSnackBarConstraints()
                self.superview?.layoutIfNeeded()
            })
    }

    private func constraintSnackBar(in view: UIView) {
        view.addSubview(self)

        self.snp.makeConstraints { make in
            make.top.equalTo(contextView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }

        addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(contextView.safeAreaLayoutGuide)
        }
    }

    private func updateSnackBarConstraints() {
        self.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
    }

    private func updateMessageLabelConstraintsForDismiss() {
        messageLabel.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func updateConstraintsForDissmis() {
        self.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
            make.top.equalTo(contextView.snp.bottom)
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
        messageLabel.alpha = CustomConstants.alphaValueTransparent
        backgroundColor = .deepGray
    }

    func defineLayoutForViews() {
        constraintSnackBar(in: contextView)
    }

}
