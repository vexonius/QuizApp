import Combine
import UIKit
import CombineReachability
import Reachability

class HomeViewController: BaseViewController {

    private var filtersSegmentedControl: ClearSegmentedControll!
    private var errorPlaceholder: ErrorPlaceholderView!

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

        bindViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        styleNavigationBar()
    }

    private func styleNavigationBar() {
        tabBarController?.title = LocalizedStrings.appName.localizedString
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

        viewModel
            .$filters
            .sink { [weak self] filters in
                self?.filtersSegmentedControl.updateSegments(segments: filters)
            }
            .store(in: &cancellables)
    }

}

extension HomeViewController: ConstructViewsProtocol {

    func createViews() {
        errorPlaceholder = ErrorPlaceholderView()
        view.addSubview(errorPlaceholder)

        filtersSegmentedControl = ClearSegmentedControll()
        view.addSubview(filtersSegmentedControl)
    }

    func styleViews() {
        filtersSegmentedControl.selectedSegmentTintColor = .white
    }

    func defineLayoutForViews() {
        errorPlaceholder.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        filtersSegmentedControl.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.componentsInset)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.height.equalTo(DesignConstants.ControlComponents.segmentedControlHeight)
        }
    }

}
