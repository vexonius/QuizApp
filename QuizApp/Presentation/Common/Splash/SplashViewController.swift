import UIKit
import SnapKit

class SplashViewController: UIViewController {

    private var viewModel: SplashViewModel

    private var logoLabel: UILabel!
    private var gradientLayer: CAGradientLayer!

    private let gradientStartPoint = CGPoint(x: 0.5, y: 1)
    private let gradientEndPoint = CGPoint(x: 0.5, y: 0)

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

extension SplashViewController: ConstructViewsProtocol {

    func createViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)

        logoLabel = UILabel()
        view.addSubview(logoLabel)
    }

    func styleViews() {
        logoLabel.text = LocalizedStrings.appName.localizedString
        logoLabel.textAlignment = .center
        logoLabel.textColor = .white
        logoLabel.font = .sourceSansPro(
            ofSize: DesignConstants.FontSize.heading.cgFloat,
            ofWeight: SourceSansProWeight.bold)

        gradientLayer.type = .axial
        gradientLayer.startPoint = gradientStartPoint
        gradientLayer.endPoint = gradientEndPoint
        gradientLayer.colors = [UIColor.darkerPurple.cgColor, UIColor.lighterPurple.cgColor]
    }

    func defineLayoutForViews() {
        logoLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

}
