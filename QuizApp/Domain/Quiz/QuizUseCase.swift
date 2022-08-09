class QuizUseCase: QuizUseCaseProtocol {

    private let quizRepository: QuizRepositoryProtocol

    init(quizRepository: QuizRepositoryProtocol) {
        self.quizRepository = quizRepository
    }

    var quizes: [QuizModel] {
        get async throws {
            let repoModel = try await quizRepository.quizes

            return repoModel.map { QuizModel(from: $0) }
        }
    }

    func getQuizes(for category: String)  async throws -> [QuizModel] {
        let repoModel = try await quizRepository.getQuizes(for: category)

        return repoModel.map { QuizModel(from: $0) }
    }

}
