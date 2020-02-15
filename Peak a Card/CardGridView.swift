import SwiftUI
import GridStack

struct CardGridView: View {

    let deckValues = ["0", "1/2", "1", "2", "3", "5", "8", "13", "20", "40", "100", "∞", "?", "☕️" ]
    @State private var animationAmount: Double = 0.0
    @State private var yOffset: [CGFloat] = {
        return (0 ..< 14).map { CGFloat(100 * $0) }
    }()

    var body: some View {
        NavigationView {
            VStack {
                GridStack(minCellWidth: 100, spacing: Stylesheet.margin(.large), numItems: deckValues.count, alignment: .leading) { index, cellWidth in
                    Card(number: self.deckValues[index])
                        .frame(width: cellWidth, height: cellWidth * 1.2, alignment: .center)
                        .opacity(self.animationAmount)
                        .offset(x: 0, y: self.yOffset[index])
                        .animation(Animation.easeOut(duration: 0.5))
                        .onAppear {
                            self.animationAmount = 1.0
                            self.yOffset[index] = .zero
                        }
                    .gesture(
                        TapGesture()
                            .onEnded { _ in

                            }
                    )
                }
                .background(Stylesheet.color(.background))
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarTitle("app_name", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardGridView()
    }
}
