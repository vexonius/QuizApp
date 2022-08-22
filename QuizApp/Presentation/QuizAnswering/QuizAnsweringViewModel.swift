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

    private var currentQuestionNumber: Int {
        currentQuestionIndex + 1
    }

    private var quizSession: QuizSessionModel?
    private var questions: [QuizQuestionModel] = []
    private let progressFormat = "%d/%d"

    private let quizUseCase: QuizUseCaseProtocol
    private let quiz: QuizModel

    init(quiz: QuizModel, quizUseCase: QuizUseCaseProtocol) {
        self.quizUseCase = quizUseCase
        self.quiz = quiz

        getQuizSession(with: quiz.id)
    }

    func onCorrectAnswerIndexPathChanged(indexPath: IndexPath) {
        correctAnswerIndex = indexPath
    }

    func onAnswerGuessed(_ answer: AnswerCellModel) {
        guard !progress.isEmpty else { return }

        isTableViewInteractionEnabled = false
        progress[currentQuestionIndex] = answer.isCorrect ? .correct : .incorrect

        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.answerUpdateDelay) {
            self.currentQuestionIndex += 1
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

    private func load(session: QuizSessionModel) {
        self.quizSession = session
        questions = session.questions
        progress = .init(repeating: .unanswered, count: quiz.numberOfQuestions)
        prepareCurrentAnswerModels()
    }

    private func getQuizSession(with id: Int) {
        Task {
            do {
                let quizSession = try await quizUseCase.startQuiz(with: id)

                await MainActor.run {
                    load(session: quizSession)
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
