class QuizUseCase: QuizUseCaseProtocol {

    private let quizRepository: QuizRepositoryProtocol

    init(quizRepository: QuizRepositoryProtocol) {
        self.quizRepository = quizRepository
    }

    var quizzes: [QuizModel] {
        get async throws {
            try await quizRepository
                .quizzes
                .map { QuizModel(from: $0) }
        }
    }

    func getQuizzes(for category: String)  async throws -> [QuizModel] {
        try await quizRepository
            .getQuizzes(for: category)
            .map { QuizModel(from: $0) }
    }

    func getLeaderboard(for quizId: Int)  async throws -> [UserRankingModel] {
        try await quizRepository
            .getLeaderboard(for: quizId)
            .map { UserRankingModel(from: $0) }
    }

    func startQuiz(with id: Int) async throws -> QuizSessionModel {
        let sessionRepoModel = try await quizRepository
            .startQuiz(with: id)

        return QuizSessionModel(from: sessionRepoModel)
    }

}
