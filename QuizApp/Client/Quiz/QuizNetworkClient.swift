class QuizNetworkClient: QuizNetworkClientProtocol {

    private let baseNetworkClient: BaseNetworkClientProtocol

    init(baseNetworkClient: BaseNetworkClientProtocol) {
        self.baseNetworkClient = baseNetworkClient
    }

    var quizzes: [QuizResponse] {
        get async throws {
            try await baseNetworkClient.get(
                url: QuizEndpoints.quizzes.path,
                params: [:],
                headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
        }
    }

    func getQuizzes(for category: String)  async throws -> [QuizResponse] {
        try await baseNetworkClient.get(
            url: QuizEndpoints.quizzes.path,
            params: [QuizEndpointsParams.category.value: category],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
    }

    func leaderboard(for quizId: Int) async throws -> [UserRankingResponse] {
        try await baseNetworkClient.get(
            url: QuizEndpoints.leaderboard.path,
            params: [QuizEndpointsParams.quizId.value: String(quizId)],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
    }

}
