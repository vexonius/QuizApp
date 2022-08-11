import UIKit

class CombineTableViewDataSource<Element>: NSObject, UITableViewDataSource {

    public typealias CellFactory =
        (CombineTableViewDataSource<Element>, UITableView, IndexPath, Element) -> UITableViewCell

    private var cellFactory: CellFactory
    private var elements: [Element] = []

    init(cellFactory: @escaping CellFactory) {
        self.cellFactory = cellFactory

        super.init()
    }

    func model(at position: Int) -> Element? {
        guard
            !elements.isEmpty,
            position <= elements.count
        else { return nil }

        return elements[position]
    }

    func push(elements: [Element], to tableView: UITableView) {
        self.elements = elements
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cellFactory(self, tableView, indexPath, elements[indexPath.row])
    }

}
