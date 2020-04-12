import SwiftUI

struct JoinSessionView: View {

    @EnvironmentObject var store: AppStore
    @State private var code: String = ""
    @State private var activityAnimatorIsAnimating = true
    private var shouldDisableButton: Bool {
        self.store.state.sessionId == nil
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("join_session_join")
                    .fontWeight(.medium)
                    .font(Stylesheet.font(.xl))
                    .foregroundColor(Stylesheet.color(.primary))
                    .lineLimit(.none)
                    .padding(.top)

                ZStack(alignment: .trailing) {
                    TextField("join_session_code", text: $code, onCommit: {
                        self.store.dispatch(action: .session(.verifySession(code: self.code)))
                    })
                        .keyboardType(.numberPad)
                        .padding()
                        .foregroundColor(Stylesheet.color(.primary))
                        .background(Stylesheet.color(.background))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(Stylesheet.color(.primary), lineWidth: 1.5))
                        .padding(.bottom)

                    if store.state.isRequestingSession {
                        ActivityIndicator(
                            isAnimating: self.$activityAnimatorIsAnimating, style: .medium
                        ).padding([.trailing, .bottom])
                    }

                    if store.state.sessionId != nil {
                        Image(systemName: "checkmark.circle.fill")
                            .padding([.trailing, .bottom])
                            .font(Stylesheet.font(.m))
                            .foregroundColor(Stylesheet.color(.success))
                    }

                    if store.state.sessionErrored {
                        Image(systemName: "exclamationmark.circle.fill")
                            .padding([.trailing, .bottom])
                            .font(Stylesheet.font(.m))
                            .foregroundColor(Stylesheet.color(.error))
                    }
                }
                AppleButton()
                    .opacity(shouldDisableButton ? 0.4 : 1.0)
                    .disabled(shouldDisableButton)
                GoogleButton()
                    .opacity(shouldDisableButton ? 0.4 : 1.0)
                    .disabled(shouldDisableButton)
                Spacer()
            }
            .padding()
            .background(Stylesheet.color(.background))
            .navigationBarTitle("app_name", displayMode: .inline)
        }
    }
}

struct JoinSessionView_Previews: PreviewProvider {
    static var previews: some View {
        JoinSessionView()
    }
}
