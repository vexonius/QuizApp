import Combine
import UIKit
import Reachability

class HomeViewModel {

    private struct CustomConstants {
        static let minimumSearchTextLength = 2
    }

    @Published private(set) var isErrorPlaceholderVisible: Bool = false
    @Published private(set) var errorMessage: String?

    @Published private(set) var isTableViewVisible: Bool = false
    @Published private(set) var areFiltersVisible: Bool = false

    @Published private(set) var filters: [CategoryFilter] = []
    @Published private(set) var filteredQuizes: [QuizCellModel] = []

    @Published private(set) var lastSearchedTerm: String?
    @Published private(set) var lastSelectedCategory: CategoryFilter?

    private var quizes: [QuizCellModel] = []

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
        Task {
            guard
                let selectedCategoryModel = categories.first(where: { $0.index == index }),
                selectedCategoryModel.category != .uncategorized
            else {
                await MainActor.run {
                    self.filteredQuizes = quizes
                    self.lastSelectedCategory = nil
                }

                return
            }

            let filteredQuizes = await filterQuizes(for: selectedCategoryModel.category)

            await MainActor.run {
                self.filteredQuizes = filteredQuizes
                self.lastSelectedCategory = selectedCategoryModel
            }
        }
    }

    func onQuizSelected(_ quiz: QuizCellModel) {
        coordinator.routeToQuizDetails(quiz: quiz.toModel())
    }

    func onSearchTextChanged(_ searchText: String) {
        guard searchText.count > CustomConstants.minimumSearchTextLength else {
            self.filteredQuizes = []
            lastSearchedTerm = nil

            return
        }

        Task {
            let filteredQuizzes = await filterQuizes(containing: searchText)

            await MainActor.run {
                self.filteredQuizes = filteredQuizzes
                lastSearchedTerm = searchText
            }
        }
    }

    func switchFiltering(for mode: QuizzesFilteringMode) {
        switch mode {
        case .home:
            guard let lastSelectedCategory = lastSelectedCategory else { 
                filteredQuizes = quizes 
                
                return
            }

            onCategoryChange(for: lastSelectedCategory.index)
        case .search:
            guard let lastSearchedTerm = lastSearchedTerm else {
                filteredQuizes = []
            
                return
            }

            onSearchTextChanged(lastSearchedTerm)
        }
    }

    private func observeNetworkChanges() {
        networkService
            .networkState
            .sink { [weak self] networkState in
                guard let self = self else { return }

                switch networkState {
                case .unavailable:
                    self.isTableViewVisible = false
                    self.areFiltersVisible = false
                    self.showNoNetworkError()
                default:
                    self.isErrorPlaceholderVisible = false
                    self.isTableViewVisible = true
                    self.areFiltersVisible = true
                    self.fetchQuizes()
                }
            }
            .store(in: &cancellables)
    }

    private func showNoNetworkError() {
        errorMessage = LocalizedStrings.networkErrorDescription.localizedString
        isErrorPlaceholderVisible = true
    }

    private func filterQuizes(containing text: String) async -> [QuizCellModel] {
        quizes
            .filter { $0.name.lowercased().contains(text) }
            .map { QuizCellModel(from: $0, highlight: text) }
    }

    private func filterQuizes(for category: Category) async -> [QuizCellModel] {
        quizes
            .filter { $0.category == category }
    }

    private func fetchQuizes() {
        Task {
            do {
                let quizes = try await quizUseCase
                    .quizzes
                    .map { QuizCellModel(from: $0) }

                await MainActor.run {
                    self.quizes = quizes
                    self.filters = categories
                }
            } catch {
                self.errorMessage = LocalizedStrings.serverErrorMessage.localizedString
            }
        }
    }

}

enum QuizzesFilteringMode {

    case home
    case search

}
