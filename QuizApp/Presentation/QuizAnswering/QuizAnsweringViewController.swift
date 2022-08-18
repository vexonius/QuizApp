import Combine
import UIKit

class QuizAnsweringViewController: BaseViewController {

    private struct CustomConstants {
        static let progressHeaderHeight = 50
    }

    private var tableView: UITableView!
    private var progressView: ProgressView!
    private var datasource: CombineTableViewDataSource<AnsweringCellProtocol>!

    private let viewModel: QuizAnsweringViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: QuizAnsweringViewModel) {
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
        title = LocalizedStrings.appName.localizedString
    }

    private func createDataSource() {
        datasource = CombineTableViewDataSource<AnsweringCellProtocol>(cellFactory: cellConfig)
        tableView.dataSource = datasource
    }

}

extension QuizAnsweringViewController: BindViewsProtocol {

    func bindViewModel() {
        viewModel
            .$currentQuestionCellModels
            .receive(subscriber: tableView.items(datasource))

        viewModel
            .$isTableViewInteractionEnabled
            .assign(to: \.isUserInteractionEnabled, on: tableView)
            .store(in: &cancellables)
    }

    func bindViews() {
        tableView
            .modelSelected(AnsweringCellProtocol.self)
            .compactMap { $0 as? AnswerCellModel }
            .sink { [weak self] answer in
                self?.viewModel.onAnswerGuessed(answer)
            }
            .store(in: &cancellables)

        tableView
            .rowSelected
            .map { [weak self] _ in
                self?.viewModel.correctAnswerIndex
            }
            .sink { [weak self] indexPath in
                guard
                    let self = self,
                    let indexPath = indexPath
                else { return }

                self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
            .store(in: &cancellables)
    }

}

extension QuizAnsweringViewController: ConstructViewsProtocol {

    func createViews() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.reuseIdentifier)
        tableView.register(AnswerCell.self, forCellReuseIdentifier: AnswerCell.reuseIdentifier)
        view.addSubview(tableView)

        progressView = ProgressView()
        view.addSubview(progressView)
    }

    func styleViews() {
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = UITableView.automaticDimension

        progressView.update()
    }

    func defineLayoutForViews() {
        progressView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.contentInset)
            make.height.equalTo(CustomConstants.progressHeaderHeight)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(DesignConstants.Insets.contentInset)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension QuizAnsweringViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

}

extension QuizAnsweringViewController {

    var cellConfig: CombineTableViewDataSource<AnsweringCellProtocol>.CellFactory {
        { _, tableView, indexPath, model -> UITableViewCell in
            switch model.cellType {
            case .answer:
                let customCell: AnswerCell? = tableView.dequeueCell(for: indexPath, with: AnswerCell.reuseIdentifier)
                let model: AnswerCellModel? = model as? AnswerCellModel

                guard
                    let customCell = customCell,
                    let model = model
                else {
                    return UITableViewCell()
                }

                if model.isCorrect {
                    self.viewModel.onCorrectAnswerIndexPathChanged(indexPath: indexPath)
                }

                customCell.bind(with: model)

                return customCell
            case .question:
                let customCell: QuestionCell? = tableView
                    .dequeueCell(for: indexPath, with: QuestionCell.reuseIdentifier)
                let model: QuestionCellModel? = model as? QuestionCellModel

                guard
                    let customCell = customCell,
                    let model = model
                else {
                    return UITableViewCell()
                }

                customCell.bind(with: model)

                return customCell
            }
        }
    }

}
