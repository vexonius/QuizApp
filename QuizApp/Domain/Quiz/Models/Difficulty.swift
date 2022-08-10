enum Difficulty: String {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

    var enumerated: Int {
        switch self {
        case .easy:
            return 1
        case .normal:
            return 2
        case .hard:
            return 3
        }
    }

}
