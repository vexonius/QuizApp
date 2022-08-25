import Combine
import UIKit
import CombineReachability
import Reachability

class SearchViewController: BaseViewController {

    private var errorPlaceholder: ErrorPlaceholderView!
    private var quizTableView: UITableView!
    private var searchBar: SearchBarView!
    private var datasource: CombineTableViewDataSource<QuizCellModel>!

    private var cancellables = Set<AnyCancellable>()
    private let viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        styleNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        tabBarController?.navigationItem.titleView = nil
    }

    private func styleNavigationBar() {
        tabBarController?.title = ""
        tabBarController?.navigationItem.titleView = searchBar
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

extension SearchViewController: BindViewsProtocol {

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
            .$filteredQuizzes
            .receive(subscriber: quizTableView.items(datasource))
    }

    func bindViews() {
        quizTableView
            .modelSelected(QuizCellModel.self)
            .sink { [weak self] model in
                self?.viewModel.onQuizSelected(model)
            }
            .store(in: &cancellables)

        searchBar
            .inputLabel
            .textDidChange
            .removeDuplicates()
            .sink { [weak self] searchedText in
                self?.viewModel.onSearchTextChanged(searchedText)
            }
            .store(in: &cancellables)

        searchBar
            .inputLabel
            .textDidBeginEditing
            .sink { textView in
                guard let textView = textView as? RoundedTextInput else { return }

                textView.styleForInFocus()
            }
            .store(in: &cancellables)

        searchBar
            .inputLabel
            .textDidEndEditing
            .sink { textView in
                guard let textView = textView as? RoundedTextInput else { return }

                textView.styleForOutOfFocus()
            }
            .store(in: &cancellables)

        searchBar
            .searchButton
            .throttledTap()
            .sink { [weak self] _ in
                guard
                    let self = self,
                    let searchedText = self.searchBar.inputLabel.text
                else { return }

                self.viewModel.onSearchTextChanged(searchedText)
            }
            .store(in: &cancellables)
    }

}

extension SearchViewController: ConstructViewsProtocol {

    func createViews() {
        errorPlaceholder = ErrorPlaceholderView()
        view.addSubview(errorPlaceholder)

        searchBar = SearchBarView()
        searchBar.inputLabel.delegate = self
        createQuizTableView()
    }

    func styleViews() {
        quizTableView.backgroundColor = .clear
        quizTableView.showsVerticalScrollIndicator = false
    }

    func defineLayoutForViews() {
        errorPlaceholder.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        quizTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.contentInset)
        }
    }

}

extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }

}

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        DesignConstants.QuizCell.height.cgFloat
    }

}

extension SearchViewController {

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
