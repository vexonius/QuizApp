import Combine
import Foundation

class QuizAnsweringViewModel {

    private struct Constants {
        static let answerUpdateDelay = 0.5
    }

    @Published var currentQuestionCellModels: [AnsweringCellProtocol] = []
    @Published var isTableViewInteractionEnabled: Bool = true
    @Published var correctAnswerIndex: IndexPath?
    @Published var currentQuestionIndex: Int = 0
    @Published var progress: [AnsweredResult] = []
    @Published var progressText: String = ""

    private var quizSession: QuizSessionModel?
    private var questions: [QuizQuestionModel] = []
    private var currentQuestionNumber: Int {
        currentQuestionIndex + 1
    }

    private let quizUseCase: QuizUseCaseProtocol
    private let quiz: QuizModel
    private let progressFormat = "%d/%d"

    init(quiz: QuizModel, quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
        self.quiz = quiz

        getQuizSession(with: quiz.id)
    }

    func onCorrectAnswerIndexPathChanged(indexPath: IndexPath) {
        correctAnswerIndex = indexPath
    }

    func onAnswerGuessed(_ answer: AnswerCellModel) {
        isTableViewInteractionEnabled = false

        progress[currentQuestionIndex] = answer.isCorrect ? .correct : .false
        currentQuestionIndex += 1

        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.answerUpdateDelay) {
            self.prepareCurrentAnswerModels()
        }
    }

    private func prepareCurrentAnswerModels() {
        var models: [AnsweringCellProtocol] = []

        guard !questions.isEmpty else {
            finishQuiz()

            return
        }

        let question = questions.removeFirst()

        models.append(QuestionCellModel(from: question))
        models.append(contentsOf: question.answers.map { AnswerCellModel(from: $0) })

        currentQuestionCellModels = models
        isTableViewInteractionEnabled = true
        updateProgress()
    }

    private func updateProgress() {
        progressText = String(format: progressFormat, currentQuestionNumber, quiz.numberOfQuestions)
    }

    private func getQuizSession(with id: Int) {
        Task {
            do {
                let quizSession = try await quizUseCase.startQuiz(with: id)

                await MainActor.run {
                    self.quizSession = quizSession
                    self.questions = quizSession.questions
                    self.prepareCurrentAnswerModels()
                    self.progress = .init(repeating: .unanswered, count: quiz.numberOfQuestions)
                    self.updateProgress()

                }
            } catch {
                debugPrint(error)
            }
        }
    }

    private func finishQuiz() {
        // To be implemented
    }

}
