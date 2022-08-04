import Combine
import Reachability

protocol NetworkServiceProtocol {

    var networkState: CurrentValueSubject<Reachability.Connection, Never> { get }

    func startObservingNetwork()

    func stopObservingNetwork()

}
