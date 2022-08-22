class QuizRepository: QuizRepositoryProtocol {

    private let quizNetworkClient: QuizNetworkClientProtocol

    init(quizNetworkClient: QuizNetworkClientProtocol) {
        self.quizNetworkClient = quizNetworkClient
    }

    var quizzes: [QuizRepoModel] {
        get async throws {
            try await quizNetworkClient
                .quizzes
                .map { QuizRepoModel(from: $0) }
        }
    }

    func getQuizzes(for category: String)  async throws -> [QuizRepoModel] {
        try await quizNetworkClient
            .getQuizzes(for: category)
            .map { QuizRepoModel(from: $0) }
    }

    func getLeaderboard(for quizId: Int)  async throws -> [UserRankingRepoModel] {
        try await quizNetworkClient
            .getLeaderboard(for: quizId)
            .map { UserRankingRepoModel(from: $0) }
    }

    func startQuiz(with id: Int) async throws -> QuizSessionRepoModel {
        let quizQuestionsResponse = try await quizNetworkClient
            .startQuiz(with: id)

        return QuizSessionRepoModel(from: quizQuestionsResponse)
    }

    func finishQuiz(
        for sessionId: String,
        with result: QuizResultRepoModel
    ) async throws -> QuizSessionResultRepoModel {
        let quizSessionResultResponse = try await quizNetworkClient
            .finishQuiz(for: sessionId, with: result.toModel())

        return QuizSessionResultRepoModel(from: quizSessionResultResponse)
    }

}
