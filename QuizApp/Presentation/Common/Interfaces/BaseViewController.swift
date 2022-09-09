import Foundation
import UIKit

class BaseViewController: UIViewController {

    private var backgroundLayer = PopGradient()

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundLayer.frame = view.bounds
        view.layer.addSublayer(backgroundLayer)
    }

    override func viewDidLayoutSubviews() {
        backgroundLayer.frame = view.bounds

        super.viewDidLayoutSubviews()
    }

}
