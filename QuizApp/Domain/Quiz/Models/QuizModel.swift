struct QuizModel {

    let id: Int
    let name: String
    let description: String
    let category: Category
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: Difficulty

}

extension QuizModel {

    init(from model: QuizRepoModel) {
        self.init(
            id: model.id,
            name: model.name,
            description: model.description,
            category: Category(rawValue: model.category) ?? .uncategorized,
            imageUrl: model.imageUrl,
            numberOfQuestions: model.numberOfQuestions,
            difficulty: Difficulty(rawValue: model.difficulty) ?? .easy)
    }

}
