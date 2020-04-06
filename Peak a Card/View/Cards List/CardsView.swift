import SwiftUI
import GridStack

struct CardsView: View {

    @EnvironmentObject var store: AppStore
    @State private var opacity: Double = 0.0
    @State private var yOffset: CGFloat = 100
    @State private var isFlipped: Bool = true

    var body: some View {
        NavigationView {
            ZStack {
                GridStack(minCellWidth: 100, spacing: Stylesheet.margin(.large), numItems: self.store.state.cards.count, alignment: .leading) { index, cellWidth in
                    CardView(card: self.store.state.cards[index], isFlipped: self.$isFlipped)
                        .frame(width: cellWidth, height: cellWidth * 1.3, alignment: .center)
                        .opacity(self.opacity)
                        .offset(x: 0, y: self.yOffset)
                        .animation(Animation.easeOut(duration: 0.2).delay(0.2 * Double(index)))
                        .gesture(
                            TapGesture()
                                .onEnded { _ in
                                    let card = self.store.state.cards[index]
                                    self.store.dispatch(action: .cards(.select(card: card)))
                            }
                        )
                        .onAppear {
                            self.opacity = 1.0
                            self.yOffset = .zero
                        }
                }
                .background(Stylesheet.color(.background))
                .edgesIgnoringSafeArea(.bottom)
                .disabled(self.store.state.selectedCard != nil)
                .animation(.easeInOut)

                if self.store.state.selectedCard != nil {
                    CardDetailView().environmentObject(self.store)
                }
            }
            .navigationBarTitle("app_name", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            self.store.dispatch(action: .cards(.get))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
    }
}
