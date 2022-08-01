import Combine
import Reachability

class HomeViewModel {

    @Published private(set) var isErrorPlaceholderVisible: Bool = true
    @Published private(set) var errorTitle: String?
    @Published private(set) var errorDescription: String?

    init() {

    }

    func onNetworkStateChanged(_ connection: Reachability.Connection) {
        switch connection {
        case .unavailable:
            showNoNetworkError()
            debugPrint("Network unreachable")
        default:
            debugPrint("Network reachable")
            isErrorPlaceholderVisible = false
            // load quizes
        }
    }

    private func showNoNetworkError() {
        errorTitle = LocalizedStrings.networkError.localizedString
        errorDescription = LocalizedStrings.networkErrorDescription.localizedString
        isErrorPlaceholderVisible = true
    }

}
