import SwiftUI

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel

    @State var selectedCategory: Int?

    private let numberOfPlaceholderItems = 4

    var body: some View {
        List {
            ForEach(viewModel.filteredQuizzes, id: \.id) { quiz in
                QuizItemView(quiz: quiz)
                    .frame(maxWidth: .infinity)
                    .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                    .listRowBackground(Color.clear)
                    .transition(.opacity)
            }
        }
        .emptyListPlaceholder(view: AnyView(QuizItemPlaceholderView()), visible: viewModel.filteredQuizzes.isEmpty)
        .modifier(ScrollViewBackgroundModifier())
        .brandStyleBackground()
        .onAppear(perform: viewModel.observeNetworkChanges)
    }

}
