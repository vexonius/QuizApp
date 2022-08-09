import Combine
import Reachability
import UIKit

class HomeViewModel {

    @Published private(set) var isErrorPlaceholderVisible: Bool = false
    @Published private(set) var errorTitle: String?
    @Published private(set) var errorDescription: String?
    @Published private(set) var filters: [QuizCategory] = []

    private let mockedFilters = ["All", "Sports", "Oscars", "Music"]

    private let networkService: NetworkServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService

        observeNetworkChanges()
        mockFilters()
    }

    private func observeNetworkChanges() {
        networkService.networkState.sink { [weak self] networkState in
            guard let self = self else { return }

            switch networkState {
            case .unavailable:
                self.showNoNetworkError()
            default:
                self.isErrorPlaceholderVisible = false
            }
        }
        .store(in: &cancellables)
    }

    private func showNoNetworkError() {
        errorTitle = LocalizedStrings.networkError.localizedString
        errorDescription = LocalizedStrings.networkErrorDescription.localizedString
        isErrorPlaceholderVisible = true
    }

    private func mockFilters() {
        Task(priority: .background) {
            let quizCategories = mockedFilters
                .enumerated()
                .map { (index, filter) in
                    // will update colors when we get real data
                    QuizCategory(index: index, title: filter, tint: UIColor.accentBlue)
                }

            await MainActor.run {
                filters = quizCategories
            }
        }
    }

}
