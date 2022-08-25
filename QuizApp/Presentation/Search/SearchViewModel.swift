import Combine
import UIKit
import Reachability

class SearchViewModel {

    private struct CustomConstants {
        static let minimumSearchTextLength = 2
    }

    @Published private(set) var errorMessage: String?
    @Published private(set) var isErrorPlaceholderVisible: Bool = false

    @Published private(set) var isTableViewVisible: Bool = false
    @Published private(set) var filteredQuizzes: [QuizCellModel] = []

    private var quizzes: [QuizCellModel] = []
    private var cancellables = Set<AnyCancellable>()

    private let coordinator: QuizCoordinatorProtocol
    private let networkService: NetworkServiceProtocol
    private let quizUseCase: QuizUseCaseProtocol

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

    func onSearchTextChanged(_ searchText: String) {
        guard searchText.count > CustomConstants.minimumSearchTextLength else {
            self.filteredQuizzes = []

            return
        }

        Task {
            let filteredQuizzes = await filterQuizzes(containing: searchText)

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
                    self.showNoNetworkError()
                default:
                    self.isErrorPlaceholderVisible = false
                    self.isTableViewVisible = true
                    self.fetchQuizzes()
                }
            }
            .store(in: &cancellables)
    }

    private func showNoNetworkError() {
        errorMessage = LocalizedStrings.networkErrorDescription.localizedString
        isErrorPlaceholderVisible = true
    }

    private func filterQuizzes(containing text: String) async -> [QuizCellModel] {
        quizzes
            .filter { $0.name.lowercased().contains(text) }
            .map { QuizCellModel(from: $0, highlight: text) }
    }

    private func fetchQuizzes() {
        Task {
            do {
                let quizzes = try await quizUseCase
                    .quizzes
                    .map { QuizCellModel(from: $0) }

                await MainActor.run {
                    self.quizzes = quizzes
                }
            } catch {
                self.errorMessage = LocalizedStrings.serverErrorMessage.localizedString
            }
        }
    }

}
