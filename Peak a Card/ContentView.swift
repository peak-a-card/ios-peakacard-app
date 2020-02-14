import SwiftUI
import GridStack

struct ContentView: View {

    let deckValues = ["0", "1/2", "1", "2", "3", "5", "8", "13", "20", "40", "100", "∞", "?", "☕️" ]

    var body: some View {
        NavigationView {
            GridStack(minCellWidth: 100, spacing: Stylesheet.margin(.large), numItems: deckValues.count, alignment: .leading) { index, cellWidth in
                Card(number: self.deckValues[index])
                    .frame(width: cellWidth, height: cellWidth * 1.2, alignment: .center)
            }
            .background(Stylesheet.color(.background))
            .navigationBarTitle("app_name", displayMode: .inline)
        }
        .background(Stylesheet.color(.primary))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
