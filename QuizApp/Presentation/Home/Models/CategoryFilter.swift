import UIKit

struct CategoryFilter: Hashable {

    let index: Int
    let title: String
    let category: Category
    let tint: UIColor

    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }

}
