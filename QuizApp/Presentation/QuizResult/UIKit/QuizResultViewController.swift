import Combine
import UIKit

class QuizResultViewController: BaseViewController {

    private struct CustomConstants {

        static let resultLabelFontSize = 88
        static let centerYOffset = -60

    }

    private var resultLabel: UILabel!
    private var finishButton: RoundedButton!

    private let viewModel: QuizResultViewModel
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: QuizResultViewModel) {
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

        bindViewModel()
        bindViews()
    }

    private func styleNavigationBar() {
        title = LocalizedStrings.appName.localizedString
        let barButton = UIBarButtonItem(image: nil, style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = barButton
    }

}

extension QuizResultViewController: BindViewsProtocol {

    func bindViewModel() {
        viewModel
            .$result
            .assign(to: \.text, on: resultLabel)
            .store(in: &cancellables)
    }

    func bindViews() {
        finishButton
            .throttledTap()
            .sink { [weak self] _ in
                self?.viewModel.onFinishButtonTap()
            }
            .store(in: &cancellables)
    }

}

extension QuizResultViewController: ConstructViewsProtocol {

    func createViews() {
        resultLabel = UILabel()
        view.addSubview(resultLabel)

        finishButton = RoundedButton(with: LocalizedStrings.finishQuiz.localizedString)
        view.addSubview(finishButton)
    }

    func styleViews() {
        resultLabel.textAlignment = .center
        resultLabel.textColor = .white
        resultLabel.font = .sourceSansPro(
            ofSize: CustomConstants.resultLabelFontSize.cgFloat,
            ofWeight: SourceSansProWeight.bold)
    }

    func defineLayoutForViews() {
        resultLabel.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.componentsInset)
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(CustomConstants.centerYOffset)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }

        finishButton.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide).inset(DesignConstants.Insets.componentsInset)
            make.height.equalTo(DesignConstants.InputComponents.height)
        }
    }

}
