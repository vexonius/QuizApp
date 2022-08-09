protocol QuizUseCaseProtocol {

    var quizes: [QuizModel] { get async throws }

    func getQuizes(for category: String) async throws -> [QuizModel]

}
