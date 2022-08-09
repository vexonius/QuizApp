class QuizNetworkClient: QuizNetworkClientProtocol {

    private let baseNetworkClient: BaseNetworkClientProtocol

    init(baseNetworkClient: BaseNetworkClientProtocol) {
        self.baseNetworkClient = baseNetworkClient
    }

    var quizes: [QuizResponse] {
        get async throws {
            try await baseNetworkClient.get(
                url: QuizEndpoints.quizes.path,
                params: [:],
                headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
        }
    }

    func getQuizes(for category: String)  async throws -> [QuizResponse] {
        try await baseNetworkClient.get(
            url: QuizEndpoints.quizes.path,
            params: [QuizEndpointsParams.category.value: category],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
    }

}
