struct QuizCellModel: Equatable {

    let id: Int
    let name: String
    let description: String
    let category: Category
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: Difficulty?
    var highlightedText: String?

    func toModel() -> QuizModel {
        QuizModel(
            id: id,
            name: name,
            description: description,
            category: category,
            imageUrl: imageUrl,
            numberOfQuestions: numberOfQuestions,
            difficulty: difficulty)
    }

    static func == (lhs: QuizCellModel, rhs: QuizCellModel) -> Bool {
        lhs.id == rhs.id
    }

}

extension QuizCellModel {

    init(from model: QuizModel) {
        self.init(
            id: model.id,
            name: model.name,
            description: model.description,
            category: model.category,
            imageUrl: model.imageUrl,
            numberOfQuestions: model.numberOfQuestions,
            difficulty: model.difficulty)
    }

    init(from model: QuizCellModel, highlight text: String?) {
        self.init(
            id: model.id,
            name: model.name,
            description: model.description,
            category: model.category,
            imageUrl: model.imageUrl,
            numberOfQuestions: model.numberOfQuestions,
            difficulty: model.difficulty,
            highlightedText: text)
    }

}
