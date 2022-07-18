import Foundation
import UIKit
import Combine

class BaseViewController: UIViewController {

    var cancellables: [AnyCancellable] = []

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}
