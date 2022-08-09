class QuizRepository: QuizRepositoryProtocol {

    private let quizNetworkClient: QuizNetworkClientProtocol

    init(quizNetworkClient: QuizNetworkClientProtocol) {
        self.quizNetworkClient = quizNetworkClient
    }

    var quizes: [QuizRepoModel] {
        get async throws {
            let quizesResponse = try await quizNetworkClient.quizes

            return quizesResponse.map { QuizRepoModel(from: $0) }
        }
    }

    func getQuizes(for category: String)  async throws -> [QuizRepoModel] {
        let quizesResponse = try await quizNetworkClient.getQuizes(for: category)

        return quizesResponse.map { QuizRepoModel(from: $0) }
    }

}
