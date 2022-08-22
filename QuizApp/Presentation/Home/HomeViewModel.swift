import Combine
import Reachability
import UIKit

class HomeViewModel {

    @Published private(set) var isErrorPlaceholderVisible: Bool = false
    @Published private(set) var errorTitle: String?
    @Published private(set) var errorDescription: String?

    @Published private(set) var filters: [CategoryFilter] = []
    @Published private(set) var filteredQuizes: [QuizModel] = []

    @Published private(set) var lastSearchedTerm: String?
    @Published private(set) var lastSelectedCategory: CategoryFilter?

    private var quizes: [QuizModel] = []

    private var categories: [CategoryFilter] {
        Category
            .allCases
            .enumerated()
            .map { (index, category) in
                CategoryFilter(index: index, title: category.named, category: category, tint: category.color)
            }
    }

    private let coordinator: QuizCoordinatorProtocol
    private let networkService: NetworkServiceProtocol
    private let quizUseCase: QuizUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()

    init(
        quizUseCase: QuizUseCaseProtocol,
        coordinator: QuizCoordinatorProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase

        observeNetworkChanges()
    }

    func onCategoryChange(for index: Int) {
        guard
            let selectedCategory = categories.first(where: { $0.index == index }),
            selectedCategory.category != .uncategorized
        else {
            filteredQuizes = quizes
            lastSelectedCategory = nil

            return
        }

        filteredQuizes = quizes.filter { $0.category.rawValue == selectedCategory.title }
        lastSelectedCategory = selectedCategory
    }

    func onQuizSelected(_ quiz: QuizModel) {
        coordinator.routeToQuizDetails(quiz: quiz)
    }

    func onSearchTextChanged(_ searchText: String) {
        filteredQuizes = quizes.filter { $0.name.lowercased().contains(searchText) }
        lastSearchedTerm = searchText
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

    func switchFiltering(for mode: QuizzesFilteringMode) {
        switch mode {
        case .home:
            guard let lastSelectedCategory = lastSelectedCategory else { return filteredQuizes = quizes }

            onCategoryChange(for: lastSelectedCategory.index)
        case .search:
            guard let lastSearchedTerm = lastSearchedTerm else { return filteredQuizes = [] }

            onSearchTextChanged(lastSearchedTerm)
        }
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

enum QuizzesFilteringMode {

    case home
    case search

}
