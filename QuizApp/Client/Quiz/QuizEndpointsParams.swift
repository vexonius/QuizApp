enum QuizEndpointsParams: String {

    case category
    case quizId

    var value: String {
        self.rawValue
    }

}
