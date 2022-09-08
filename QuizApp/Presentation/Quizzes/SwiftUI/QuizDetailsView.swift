import SwiftUI

struct QuizDetailsView: View {

    @ObservedObject var viewModel: QuizDetailsViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        GeometryReader { proxy in
            VStack {
                Text(LocalizedStrings.leaderboard.localizedString)
                    .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .semibold))
                    .underline(true, color: .white)
                    .padding(.trailing, 32)
                    .frame(maxWidth: calculateWidth(), alignment: .trailing)
                    .onTapGesture {
                        viewModel.onLeaderBoardLabelTap()
                    }
                VStack(alignment: .center, spacing: 16) {
                    Text(viewModel.quiz.name)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.title.cgFloat, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(.zero)
                        .multilineTextAlignment(.center)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 32)
                    Text(viewModel.quiz.description)
                        .font(.sourceSansPro(size: DesignConstants.FontSize.subtitle.cgFloat, weight: .semibold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 32)
                    AsyncImage(
                        url: URL(string: viewModel.quiz.imageUrl),
                        content: { image in
                            image
                                .resizable()
                                .scaledToFill()
                        },
                        placeholder: {
                            Color.white30
                        })
                    .frame(maxWidth: proxy.size.width - 88, maxHeight: proxy.size.height * 0.4, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: DesignConstants.Decorator.cornerSize.cgFloat))
                    Button(
                        action:viewModel.onStartQuizButtonTap,
                        label: {
                            Text(LocalizedStrings.startQuizTitle.localizedString)
                                .font(.sourceSansPro(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                    })
                    .modifier(RoundedButton())
                }
                .frame(maxWidth: calculateWidth())
                .padding(.all, 16)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white30)
                }
                .padding(.horizontal, 16)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .brandStyleBackground()
        .navigationTitle(LocalizedStrings.appName.localizedString)
    }

    func calculateWidth() -> CGFloat {
        if horizontalSizeClass == .regular {
            return CGFloat(240)
        }

        return 400.cgFloat
    }

}
