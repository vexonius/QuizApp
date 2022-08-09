import Combine
import Reachability

protocol NetworkServiceProtocol {

    var networkState: AnyPublisher<Reachability.Connection, Never> { get }

    func startObservingNetwork()

    func stopObservingNetwork()

}
