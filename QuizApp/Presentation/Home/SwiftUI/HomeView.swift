import SwiftUI
import NukeUI

struct HomeView: View {

    @ObservedObject private(set) var viewModel: HomeViewModel

    @State var selectedCategory: Int?

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(Color.clear)
        UITableView.appearance().backgroundColor = UIColor(Color.clear)
     }

    var body: some View {
        VStack {
            List {
                ForEach(viewModel.filteredQuizes, id: \.id) { quiz in
                    QuizItemView(quiz: quiz)
                        .frame(maxWidth: .infinity)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                }
            }
        }
        .brandStyleBackground()
    }

}
