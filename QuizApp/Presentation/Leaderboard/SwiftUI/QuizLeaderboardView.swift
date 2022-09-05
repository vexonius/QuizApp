import SwiftUI

struct QuizLeaderboardView: View {

    @ObservedObject var viewModel: QuizLeaderboardViewModel

    init(viewModel: QuizLeaderboardViewModel) {
        self.viewModel = viewModel

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor(.clear)
        UITableView.appearance().backgroundColor = UIColor(.clear)
    }

    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStrings.player.localizedString)
                    .font(.sourceSansPro(size: 16, weight: .semibold))
                    .frame(alignment: .trailing)
                Spacer()
                Text(LocalizedStrings.points.localizedString)
                    .font(.sourceSansPro(size: 16, weight: .semibold))
                    .frame(alignment: .leading)
            }
            .padding(.horizontal, 16)
            List {
                if viewModel.userRankings.isEmpty {
                    ForEach(0..<10) { _ in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white30)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .listRowBackground(Color.clear)
                            .listRowInsets(
                                EdgeInsets(
                                    top: .zero,
                                    leading: 16,
                                    bottom: .zero,
                                    trailing: 16))
                    }
                } else {
                    ForEach(viewModel.userRankings, id: \.position) { item in
                        makeRankItem(with: item)
                            .listRowBackground(Color.clear)
                            .listRowSeparatorTint(.white, edges: .bottom)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            .listRowInsets(
                                EdgeInsets(
                                    top: .zero,
                                    leading: 16,
                                    bottom: .zero,
                                    trailing: 16))
                    }
                }
            }
            .listStyle(PlainListStyle())
            .modifier(ScrollViewBackgroundModifier())
        }
        .brandStyleBackground()
        .navigationTitle(LocalizedStrings.appName.localizedString)
    }

    @ViewBuilder
    private func makeRankItem(with model: UserRankingCellModel) -> some View {
        HStack {
            Text(model.position)
                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .bold))
                .lineLimit(.zero)
                .frame(alignment: .leading)
            Text(model.name)
                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .semibold))
                .lineLimit(.zero)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(model.points)
                .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .bold))
                .lineLimit(.zero)
                .frame(alignment: .trailing)
        }
        .frame(height: 60)
    }

}
