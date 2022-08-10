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

}
