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
    @Published private(set) var filteredQuizzes: [QuizCellModel] = []

    private var quizzes: [QuizCellModel] = []

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
                    self.filteredQuizzes = quizzes
                }

                return
            }

            let filteredQuizzes = await filterquizzes(for: selectedCategoryModel.category)

            await MainActor.run {
                self.filteredQuizzes = filteredQuizzes
            }
        }
    }

    func onQuizSelected(_ quiz: QuizCellModel) {
        coordinator.routeToQuizDetails(quiz: quiz.toModel())
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
                    self.fetchquizzes()
                }
            }
            .store(in: &cancellables)
    }

    private func showNoNetworkError() {
        errorMessage = LocalizedStrings.networkErrorDescription.localizedString
        isErrorPlaceholderVisible = true
    }

    private func filterquizzes(for category: Category) async -> [QuizCellModel] {
        quizzes
            .filter { $0.category == category }
    }

    private func fetchquizzes() {
        Task {
            do {
                let quizzes = try await quizUseCase
                    .quizzes
                    .map { QuizCellModel(from: $0) }

                await MainActor.run {
                    self.quizzes = quizzes
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
