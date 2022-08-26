class QuizNetworkClient: QuizNetworkClientProtocol {

    private let baseNetworkClient: BaseNetworkClientProtocol

    init(baseNetworkClient: BaseNetworkClientProtocol) {
        self.baseNetworkClient = baseNetworkClient
    }

    var quizzes: [QuizResponse] {
        get async throws {
            return try await baseNetworkClient.get(
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

    func getLeaderboard(for quizId: Int) async throws -> [UserRankingResponse] {
        try await baseNetworkClient.get(
            url: QuizEndpoints.leaderboard.path,
            params: [QuizEndpointsParams.quizId.value: String(quizId)],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
    }

    func startQuiz(with id: Int) async throws -> QuizSessionResponse {
        try await baseNetworkClient.post(
            url: QuizEndpoints.startSession(id: id).path,
            params: [:],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value],
            requestBody: EmptyRequest())
    }

    func finishQuiz(for sessionId: String, with request: QuizResultRequest) async throws -> QuizSessionResultResponse {
        try await baseNetworkClient.post(
            url: QuizEndpoints.endSession(id: sessionId).path,
            params: [:],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value],
            requestBody: request)
    }

}
