class QuizNetworkClient: QuizNetworkClientProtocol {

    private let networkClient: BaseNetworkClientProtocol

    init(networkClient: BaseNetworkClientProtocol) {
        self.networkClient = networkClient
    }

    var quizzes: [QuizResponse] {
        get async throws {
            try await networkClient.get(
                url: QuizEndpoints.quizzes.path,
                params: [:],
                headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
        }
    }

    func getQuizzes(for category: String)  async throws -> [QuizResponse] {
        try await networkClient.get(
            url: QuizEndpoints.quizzes.path,
            params: [QuizEndpointsParams.category.value: category],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
    }

}
