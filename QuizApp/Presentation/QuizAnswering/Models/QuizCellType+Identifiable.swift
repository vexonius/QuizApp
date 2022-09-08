import Foundation

extension QuizCellType: Identifiable, Hashable {

    static func == (lhs: QuizCellType, rhs: QuizCellType) -> Bool {
        lhs.id == rhs.id
    }

    var id: String {
        UUID().uuidString
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
