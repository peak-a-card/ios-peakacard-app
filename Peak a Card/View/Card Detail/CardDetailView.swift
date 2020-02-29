import SwiftUI

struct CardDetailView: View {
    @EnvironmentObject var store: AppStore
    @State private var selectedCardOffset: CGSize = .zero
    private let thresholdPercentage: CGFloat = 0.5

    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.height / geometry.size.height
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.bottom)
                    .gesture(TapGesture().onEnded { _ in
                        self.store.dispatch(action: .detail(.unselect))
                    })
                
                CardView(card: self.store.state.selectedCard!)
                    .frame(width: 200, height: 200 * 1.4, alignment: .center)
                    .offset(y: self.selectedCardOffset.height)
                    .animation(.interactiveSpring())
                    .gesture(DragGesture()
                        .onChanged { self.selectedCardOffset = $0.translation }
                        .onEnded { value in
                            if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                                self.store.dispatch(action: .detail(.submit(card: self.store.state.selectedCard!)))
                                // TODO: dismiss it
                                print("submit")
                            } else {
                                self.selectedCardOffset = .zero
                                print("undo")
                            }
                        }
                )
            }
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
    }
}
