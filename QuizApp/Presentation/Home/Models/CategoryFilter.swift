import UIKit

struct CategoryFilter: Hashable {

    let index: Int
    let title: String
    let category: Category

    func hash(into hasher: inout Hasher) {
        hasher.combine(index)
    }

}
