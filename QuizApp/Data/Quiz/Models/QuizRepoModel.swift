struct QuizRepoModel {

    let id: Int
    let name: String
    let description: String
    let category: String
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: String

}

extension QuizRepoModel {

    init(from model: QuizResponse) {
        self.init(
            id: model.id,
            name: model.name,
            description: model.description,
            category: model.category,
            imageUrl: model.imageUrl,
            numberOfQuestions: model.numberOfQuestions,
            difficulty: model.difficulty)
    }

}
