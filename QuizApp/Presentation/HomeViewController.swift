import Combine
import UIKit
import CombineReachability
import Reachability

class HomeViewController: BaseViewController {

    private var errorPlaceholder: ErrorPlaceholderView!

    private var cancellables = Set<AnyCancellable>()
    private var reachability: Reachability?

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

        reachability = try? Reachability()

        bindReachability()
        bindViews()

        let quizItem = QuizCell(
            title: "Hello there",
            summary: "Quiz description that can usually span over multiple lines")
        view.addSubview(quizItem)
        quizItem.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(144)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        styleNavigationBar()
        startObservingNetwork()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        stopObservingNetwork()
    }

    private func styleNavigationBar() {
        tabBarController?.title = LocalizedStrings.appName.localizedString
    }

    private func stopObservingNetwork() {
        reachability?.stopNotifier()
    }

    private func startObservingNetwork() {
        try? reachability?.startNotifier()
    }

    private func bindReachability() {
        reachability?.reachabilityChanged
            .sink { [weak self] reachability in
                let connectionStatus = reachability.connection
                self?.viewModel.onNetworkStateChanged(connectionStatus)
            }
            .store(in: &cancellables)
    }

}

extension HomeViewController: BindViewsProtocol {

    func bindViews() {
        viewModel
            .$isErrorPlaceholderVisible
            .map { !$0 }
            .assign(to: \.isHidden, on: errorPlaceholder)
            .store(in: &cancellables)

        viewModel
            .$errorTitle
            .assign(to: \.title, on: errorPlaceholder)
            .store(in: &cancellables)

        viewModel
            .$errorDescription
            .assign(to: \.errorDescription, on: errorPlaceholder)
            .store(in: &cancellables)
    }

}

extension HomeViewController: ConstructViewsProtocol {

    func createViews() {
        errorPlaceholder = ErrorPlaceholderView()
        view.addSubview(errorPlaceholder)
    }

    func styleViews() {

    }

    func defineLayoutForViews() {
        errorPlaceholder.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
