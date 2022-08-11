import Combine
import Reachability
import UIKit

class HomeViewModel {

    @Published private(set) var isErrorPlaceholderVisible: Bool = false
    @Published private(set) var errorTitle: String?
    @Published private(set) var errorDescription: String?

    @Published private(set) var filters: [CategoryFilter] = []
    @Published private(set) var filteredQuizes: [QuizModel] = []

    private var quizes: [QuizModel] = []

    private var categories: [CategoryFilter] {
        Category
            .allCases
            .enumerated()
            .map { (index, category) in
                CategoryFilter(index: index, title: category.named, category: category, tint: category.color)
            }
    }

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
            selectedCategory.category != .uncategorized
        else {
            filteredQuizes = quizes

            return
        }

        filteredQuizes = quizes.filter { $0.category.rawValue == selectedCategory.title }
    }

    func onQuizSelected(_ quiz: QuizModel) {
        debugPrint(quiz)
    }

    private func observeNetworkChanges() {
        networkService
            .networkState
            .sink { [weak self] networkState in
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
                let quizes = try await quizUseCase.quizzes

                await MainActor.run {
                    self.quizes = quizes
                    self.filters = categories
                }
            } catch {
                showNoNetworkError()
            }
        }
    }

}
