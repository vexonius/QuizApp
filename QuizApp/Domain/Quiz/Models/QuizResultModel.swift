struct QuizResultModel {

    let sessionId: String
    let numberOfCorrectQuestions: Int
    let totalNumberOfQuestions: Int

    func toModel() -> QuizResultRepoModel {
        QuizResultRepoModel(numberOfCorrectQuestions: numberOfCorrectQuestions)
    }

}
