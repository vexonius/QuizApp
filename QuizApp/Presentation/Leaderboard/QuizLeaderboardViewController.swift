import Combine
import UIKit

class QuizLeaderboardViewController: BaseViewController {

    private struct CustomConstants {
        static let rankingCellHeight = 64
        static let headerHeight = 48
    }

    private var rankedTableView: UITableView!
    private var headerView: LeaderboardHeaderView!
    private var datasource: CombineTableViewDataSource<UserRankingCellModel>!

    private let viewModel: QuizLeaderboardViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: QuizLeaderboardViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        styleNavigationBar()

        createDataSource()

        bindViews()
        bindViewModel()
    }

    private func styleNavigationBar() {
        title = LocalizedStrings.leaderboard.localizedString
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .close, style: .plain, target: nil, action: nil)
    }

    private func createDataSource() {
        datasource = CombineTableViewDataSource<UserRankingCellModel>(cellFactory: rankingCell)
        rankedTableView.dataSource = datasource
    }

}

extension QuizLeaderboardViewController: BindViewsProtocol {

    func bindViewModel() {
        viewModel
            .$userRankings
            .receive(subscriber: rankedTableView.items(datasource))
    }

    func bindViews() {
        navigationItem
            .rightBarButtonItem?
            .tap
            .sink { [weak self] _ in
                self?.viewModel.onCloseItemTap()
            }
            .store(in: &cancellables)
    }

}

extension QuizLeaderboardViewController: ConstructViewsProtocol {

    func createViews() {
        rankedTableView = UITableView()
        rankedTableView.delegate = self
        rankedTableView.register(RankingCell.self, forCellReuseIdentifier: RankingCell.reuseIdentifier)
        view.addSubview(rankedTableView)

        headerView = LeaderboardHeaderView()
    }

    func styleViews() {
        rankedTableView.backgroundColor = .clear
        rankedTableView.separatorColor = .white
        rankedTableView.separatorInset = .zero

        // Fix for Weird inset for header view on ios 15
        if #available(iOS 15.0, *) {
            rankedTableView.sectionHeaderTopPadding = 0
        }
    }

    func defineLayoutForViews() {
        rankedTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension QuizLeaderboardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CustomConstants.rankingCellHeight.cgFloat
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CustomConstants.headerHeight.cgFloat
    }

}

extension QuizLeaderboardViewController {

    var rankingCell: CombineTableViewDataSource<UserRankingCellModel>.CellFactory {
        { _, tableView, indexPath, model -> UITableViewCell in
            guard
                let cell: RankingCell = tableView.dequeueCell(for: indexPath, with: RankingCell.reuseIdentifier)
            else {
                return UITableViewCell()
            }

            cell.bind(with: model)

            return cell
        }
    }

}
