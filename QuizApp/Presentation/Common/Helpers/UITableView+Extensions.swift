import UIKit
import Combine

extension UITableView {

    var rowSelected: AnyPublisher<Int, Never> {
        NotificationCenter
            .default
            .publisher(for: UITableView.selectionDidChangeNotification, object: self)
            .compactMap { $0.object as? UITableView}
            .compactMap { $0.indexPathForSelectedRow?.row }
            .eraseToAnyPublisher()
    }

    func modelSelected<T>(_: T.Type) -> AnyPublisher<T, Never> {
        guard let datasource = self.dataSource as? CombineTableViewDataSource<T> else {
            return Empty()
                .eraseToAnyPublisher()
        }

        return rowSelected
            .map { datasource.model(at: $0) }
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }

    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath, with reuseIdentifier: String) -> T? {
        dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T
    }

    func items<T>(
        _ dataSource: CombineTableViewDataSource<T>
    ) -> AnySubscriber<[T], Never> {
        AnySubscriber<[T], Never>(
            receiveSubscription: { subscription in
                subscription.request(.unlimited)
            },
            receiveValue: { [weak self] items -> Subscribers.Demand in
                guard let self = self else { return .none }

                if self.dataSource == nil {
                    self.dataSource = dataSource
                }

                dataSource.push(elements: items, to: self)

                return .unlimited
            },
            receiveCompletion: nil)
    }

}
