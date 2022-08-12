import Combine

class QuizDetailsViewModel {

    @Published private(set) var quiz: QuizModel

    private let coordinator: QuizCoordinatorProtocol

    init(quiz: QuizModel, coordinator: QuizCoordinatorProtocol) {
        self.coordinator = coordinator
        self.quiz = quiz
    }

    func onLeaderBoardLabelTap() {

    }

    func onStartQuizButtonTap() {

    }

}
