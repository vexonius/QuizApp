import Combine
import Reachability
import UIKit

class HomeViewModel {

    @Published private(set) var isErrorPlaceholderVisible: Bool = false
    @Published private(set) var errorTitle: String?
    @Published private(set) var errorDescription: String?

    @Published private(set) var categories: [QuizCategory] = []
    @Published private(set) var filteredQuizes: [QuizModel] = []

    private var quizes: [QuizModel] = []
    private let defaultCategoryIndex = 0

    private let networkService: NetworkServiceProtocol
    private let quizUseCase: QuizUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(quizUseCase: QuizUseCaseProtocol, networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.quizUseCase = quizUseCase

        observeNetworkChanges()
    }

    func onCategoryChange(for index: Int) {
        guard
            let selectedCategory = categories.first(where: { $0.index == index }),
            selectedCategory.index != defaultCategoryIndex
        else {
            filteredQuizes = quizes
            dump(filteredQuizes)
            return
        }

        filteredQuizes = quizes.filter { $0.category == selectedCategory.title }
    }

    private func observeNetworkChanges() {
        networkService.networkState.sink { [weak self] networkState in
            guard let self = self else { return }

            switch networkState {
            case .unavailable:
                self.showNoNetworkError()
            default:
                self.isErrorPlaceholderVisible = false

                self.fetchQuizes()
            }
        }
        .store(in: &cancellables)
    }

    private func showNoNetworkError() {
        errorTitle = LocalizedStrings.networkError.localizedString
        errorDescription = LocalizedStrings.networkErrorDescription.localizedString
        isErrorPlaceholderVisible = true
    }

    private func fetchQuizes() {
        Task {
            do {
                let quizes = try await quizUseCase.quizes
                let categories = await filterCategories(from: quizes)

                await MainActor.run {
                    self.quizes = quizes
                    self.categories = categories
                }
            } catch {
                showNoNetworkError()
            }
        }
    }

    private func filterCategories(from quizes: [QuizModel]) async -> [QuizCategory] {
        var categories = quizes
            .map { $0.category }
            .unique()

        categories.insert(QuizCategory.default, at: defaultCategoryIndex)

        return categories
            .enumerated()
            .map { (index, category) in
                QuizCategory(index: index, title: category, tint: UIColor.white)
            }
    }

}
