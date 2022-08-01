import Combine
import UIKit
import CombineReachability
import Reachability

class HomeViewController: BaseViewController {

    private var cancellables = Set<AnyCancellable>()
    private var reachability: Reachability?

    override func viewDidLoad() {
        super.viewDidLoad()

        reachability = try? Reachability()

        bindReachability()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        startObservingNetwork()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        stopObservingNetwork()
    }

    private func stopObservingNetwork() {
        reachability?.stopNotifier()
    }

    private func startObservingNetwork() {
        try? reachability?.startNotifier()
    }

    private func bindReachability() {
        reachability?.reachabilityChanged
            .sink { [weak self] reachability in
                let connectionStatus = reachability.connection
            }
            .store(in: &cancellables)
    }

}
