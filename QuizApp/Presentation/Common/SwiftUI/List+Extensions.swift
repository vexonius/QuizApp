import SwiftUI

struct EmptyListPlaceholderViewModifier: ViewModifier {

    var visible: Bool
    @State var view: AnyView
    @State var numberOfItems: Int

    @ViewBuilder
    func body(content: Content) -> some View {
        if visible {
            List {
                ForEach(0..<4) { index in
                    view
                        .listRowInsets(EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero))
                        .listRowBackground(Color.clear)
                }
            }
        } else {
            content
        }
    }

}

extension List {

    func emptyListPlaceholder(view: AnyView, visible: Bool, numberOfItems: Int = 4) -> some View {
        self.modifier(EmptyListPlaceholderViewModifier(visible: visible, view: view, numberOfItems: numberOfItems))
    }

}
