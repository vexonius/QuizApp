import Combine

class QuizLeaderboardViewModel {

    @Published var userRankings: [UserRankingModel] = []

    private let quizUseCase: QuizUseCaseProtocol
    private let coordinator: QuizCoordinatorProtocol

    init(quizId: Int, quizUseCase: QuizUseCaseProtocol, coordinator: QuizCoordinatorProtocol) {
        self.quizUseCase = quizUseCase
        self.coordinator = coordinator

        getQuizLeaderBoard(for: quizId)
    }

    func onCloseItemTap() {
        coordinator.routeBackFromLeaderBoard()
    }

    private func getQuizLeaderBoard(for quizId: Int) {
        Task {
            do {
                let rankingsModel = try await quizUseCase.getLeaderboard(for: quizId)

                await MainActor.run {
                    self.userRankings = rankingsModel
                }
            } catch {
                debugPrint(error)
            }
        }
    }

}
