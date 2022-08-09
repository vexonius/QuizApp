class QuizNetworkClient: QuizNetworkClientProtocol {

    private let networkClient: BaseNetworkClientProtocol

    init(networkClient: BaseNetworkClientProtocol) {
        self.networkClient = networkClient
    }

    var quizes: [QuizResponse] {
        get async throws {
            try await networkClient.get(
                url: QuizEndpoints.quizes.path,
                params: [:],
                headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
        }
    }

    func getQuizes(for category: String)  async throws -> [QuizResponse] {
        try await networkClient.get(
            url: QuizEndpoints.quizes.path,
            params: [QuizEndpointsParams.category.value: category],
            headers: [HeaderField.contentType.key: HeaderValue.defaultContentType.value])
    }

}
