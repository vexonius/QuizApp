protocol QuizNetworkClientProtocol {

    var quizes: [QuizResponse] { get async throws }

    func getQuizes(for category: String) async throws -> [QuizResponse]

}
