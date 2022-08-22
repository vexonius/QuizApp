struct QuizResultRepoModel {

    let numberOfCorrectQuestions: Int

    func toModel() -> QuizResultRequest {
        QuizResultRequest(numberOfCorrectQuestions: numberOfCorrectQuestions)
    }

}
