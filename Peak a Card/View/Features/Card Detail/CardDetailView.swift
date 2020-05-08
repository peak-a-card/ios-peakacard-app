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
                    VStack(alignment: .center) {
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

                        Button(action: {
                            self.selectedCardOffset = CGSize(width: 0, height: -geometry.size.height)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                self.store.dispatch(action: .detail(.submit))
                            }
                        }) {
                            Text("card_detail_submit")
                                .foregroundColor(Stylesheet.color(.primary))
                                .font(Stylesheet.font(.m))
                        }
                        .padding()
                        .background(Stylesheet.color(.background))
                        .cornerRadius(4)
                        .overlay(RoundedRectangle(cornerRadius: 4)
                        .stroke(Stylesheet.color(.primary)))
                        .padding(.top)
                        .opacity(self.selectedCardOffset == .zero ? 1.0 : 0.0)
                    }
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
