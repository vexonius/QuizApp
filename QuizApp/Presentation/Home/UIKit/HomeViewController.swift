import Combine
import UIKit
import CombineReachability
import Reachability

class HomeViewController: BaseViewController {

    private struct CustomConstants {

        static let segmentedControlTopInset = 8

    }

    private var filtersSegmentedControl: ClearSegmentedControl!
    private var errorPlaceholder: ErrorPlaceholderView!
    private var quizTableView: UITableView!
    private var datasource: CombineTableViewDataSource<QuizCellModel>!

    private var cancellables = Set<AnyCancellable>()
    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
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

        createQuizzesDataSource()

        bindViewModel()
        bindViews()

        viewModel.observeNetworkChanges()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        styleNavigationBar()
    }

    private func styleNavigationBar() {
        tabBarController?.title = LocalizedStrings.appName.localizedString
    }

    private func createQuizTableView() {
        quizTableView = UITableView()
        quizTableView.delegate = self
        quizTableView.register(QuizCell.self, forCellReuseIdentifier: QuizCell.reuseIdentifier)

        view.addSubview(quizTableView)
    }

    private func createQuizzesDataSource() {
        datasource = CombineTableViewDataSource<QuizCellModel>(cellFactory: quizCell)
        quizTableView.dataSource = datasource
    }

}

extension HomeViewController: BindViewsProtocol {

    func bindViewModel() {
        viewModel
            .$isErrorPlaceholderVisible
            .map { !$0 }
            .assign(to: \.isHidden, on: errorPlaceholder)
            .store(in: &cancellables)

        viewModel
            .$errorMessage
            .assign(to: \.errorDescription, on: errorPlaceholder)
            .store(in: &cancellables)

        viewModel
            .$isTableViewVisible
            .map { !$0 }
            .assign(to: \.isHidden, on: quizTableView)
            .store(in: &cancellables)

        viewModel
            .$areFiltersVisible
            .map { !$0 }
            .assign(to: \.isHidden, on: filtersSegmentedControl)
            .store(in: &cancellables)

        viewModel
            .$filters
            .sink { [weak self] categories in
                self?.filtersSegmentedControl.update(segments: categories)
            }
            .store(in: &cancellables)

        viewModel
            .$filteredQuizzes
            .removeDuplicates()
            .receive(subscriber: quizTableView.items(datasource))
    }

    func bindViews() {
        quizTableView
            .modelSelected(QuizCellModel.self)
            .sink { [weak self] model in
                self?.viewModel.onQuizSelected(model)
            }
            .store(in: &cancellables)

        filtersSegmentedControl
            .publisher(for: \.selectedSegmentIndex)
            .sink { [weak self] index in
                self?.viewModel.onCategoryChange(for: index)
            }
            .store(in: &cancellables)
    }

}

extension HomeViewController: ConstructViewsProtocol {

    func createViews() {
        errorPlaceholder = ErrorPlaceholderView()
        view.addSubview(errorPlaceholder)

        filtersSegmentedControl = ClearSegmentedControl()
        view.addSubview(filtersSegmentedControl)

        createQuizTableView()
    }

    func styleViews() {
        filtersSegmentedControl.selectedSegmentTintColor = .white

        quizTableView.backgroundColor = .clear
        quizTableView.showsVerticalScrollIndicator = false
    }

    func defineLayoutForViews() {
        errorPlaceholder.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        filtersSegmentedControl.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.componentsInset)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(CustomConstants.segmentedControlTopInset)
            make.height.equalTo(DesignConstants.ControlComponents.segmentedControlHeight)
        }

        quizTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(filtersSegmentedControl.snp.bottom).offset(DesignConstants.Insets.componentSpacing)
        }
    }

}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DesignConstants.QuizCell.height.cgFloat
    }

}

extension HomeViewController {

    var quizCell: CombineTableViewDataSource<QuizCellModel>.CellFactory {
        { _, tableView, indexPath, model -> UITableViewCell in
            guard let cell: QuizCell = tableView.dequeueCell(for: indexPath, with: QuizCell.reuseIdentifier) else {
                return UITableViewCell()
            }

            cell.bind(with: model)

            return cell
        }
    }

}
