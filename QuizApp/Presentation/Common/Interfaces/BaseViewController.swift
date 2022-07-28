import Foundation
import UIKit

class BaseViewController: UIViewController {

    private var backGround = PopGradient()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        backGround.frame = view.bounds
        view.layer.addSublayer(backGround)
    }

    override func viewDidLayoutSubviews() {
        backGround.frame = view.bounds

        super.viewDidLayoutSubviews()
    }

}
