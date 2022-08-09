import Combine
import Reachability

class HomeViewModel {

    @Published private(set) var isErrorPlaceholderVisible: Bool = false
    @Published private(set) var errorTitle: String?
    @Published private(set) var errorDescription: String?

    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService

        observeNetworkChanges()
    }

    private func observeNetworkChanges() {
        networkService.networkState.sink { [weak self] networkState in
            guard let self = self else { return }

            switch networkState {
            case .unavailable:
                self.showNoNetworkError()
            default:
                self.isErrorPlaceholderVisible = false

                // load quizes
            }
        }
        .store(in: &cancellables)
    }

    private func showNoNetworkError() {
        errorTitle = LocalizedStrings.networkError.localizedString
        errorDescription = LocalizedStrings.networkErrorDescription.localizedString
        isErrorPlaceholderVisible = true
    }

}
