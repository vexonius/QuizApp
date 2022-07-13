import UIKit
import SnapKit

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)

        logoLabel = UILabel()
        view.addSubview(logoLabel)

        usernameInput = CoreUI.RoundedTextInput(type: .username)
        view.addSubview(usernameInput)

        passwordInput = CoreUI.RoundedTextInput(type: .password)
        view.addSubview(passwordInput)
    }

    func styleViews() {
        gradientLayer.type = .axial
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.colors = [UIColor.darkerPurple.cgColor, UIColor.lighterPurple.cgColor]

        logoLabel.font = UIFont.sourceSansPro(ofSize: 32, ofWeight: SourceSansProWeight.bold)
        logoLabel.text = String.appName
        logoLabel.textAlignment = .center
        logoLabel.textColor = .white
    }

    func defineLayoutForViews() {
        logoLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(76)
            make.centerX.equalToSuperview()
        }

        usernameInput.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(44)
            make.top.equalTo(logoLabel.snp.bottom).offset(144)
            make.centerX.equalToSuperview()
        }

        passwordInput.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(44)
            make.top.equalTo(usernameInput.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
        }
    }

}
