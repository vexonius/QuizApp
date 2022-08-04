import Reachability
import CombineReachability
import Combine

class NetworkService: NetworkServiceProtocol {

    private(set) var networkState = CurrentValueSubject<Reachability.Connection, Never>(.unavailable)

    private var reachability: Reachability?
    private var cancellables = Set<AnyCancellable>()

    init() {
        reachability = try? Reachability()
        bindReachability()
    }

    func startObservingNetwork() {
        try? reachability?.startNotifier()
    }

    func stopObservingNetwork() {
        reachability?.stopNotifier()
    }

    private func bindReachability() {
        reachability?.reachabilityChanged
            .sink(receiveValue: { [weak self] reachability in
                self?.networkState.send(reachability.connection)
            })
            .store(in: &cancellables)
    }

}
