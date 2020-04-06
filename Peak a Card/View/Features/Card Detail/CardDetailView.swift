import SwiftUI

struct CardDetailView: View {
    @EnvironmentObject var store: AppStore
    @State private var selectedCardOffset: CGSize = .zero

    enum InteractionResult {
        case submit
        case resetPosition
        case dismiss
    }
    private func getInteractionResult(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> InteractionResult {
        let thresholdPercentage: CGFloat = 0.5
        let percentage = gesture.translation.height / geometry.size.height
        if percentage <= -thresholdPercentage {
            return .submit
        } else if percentage >= thresholdPercentage {
            return .dismiss
        } else {
            return .resetPosition
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(0.7)
                    .edgesIgnoringSafeArea(.bottom)
                    .gesture(TapGesture().onEnded { _ in
                        self.store.dispatch(action: .detail(.dismiss))
                    })

                if self.store.state.selectedCard != nil {
                    CardView(card: self.store.state.selectedCard!, isFlipped: .constant(true))
                        .frame(width: 200, height: 200 * 1.4, alignment: .center)
                        .offset(y: self.selectedCardOffset.height)
                        .animation(.interactiveSpring())
                        .gesture(DragGesture()
                            .onChanged { self.selectedCardOffset = $0.translation }
                            .onEnded { value in
                                let result = self.getInteractionResult(geometry, from: value)
                                switch result {
                                case .submit:
                                    self.store.dispatch(action: .detail(.submit))
                                case .resetPosition:
                                    self.selectedCardOffset = .zero
                                case .dismiss:
                                    self.store.dispatch(action: .detail(.dismiss))
                                }
                            }
                    )
                }
            }
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
    }
}
