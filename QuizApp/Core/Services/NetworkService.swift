import Reachability
import CombineReachability
import Combine

class NetworkService: NetworkServiceProtocol {

    var networkState: AnyPublisher<Reachability.Connection, Never> {
        networkStateSubject.eraseToAnyPublisher()
    }

    private let networkStateSubject = CurrentValueSubject<Reachability.Connection, Never>(.unavailable)

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
            .sink { [weak self] reachability in
                self?.networkStateSubject.send(reachability.connection)
            }
            .store(in: &cancellables)
    }

}
