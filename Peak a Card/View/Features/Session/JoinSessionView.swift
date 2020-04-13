import SwiftUI

struct JoinSessionView: View {

    @EnvironmentObject var store: AppStore
    @State private var code: String = ""
    @State private var activityIndicatorIsAnimating = true
    private var shouldDisableButton: Bool {
        code.isEmpty
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

                if store.state.sessionErrored {
                    Text("join_session_error_no_session")
                        .foregroundColor(Stylesheet.color(.error))
                        .font(Stylesheet.font(.m))
                        .padding(.top)
                }

                TextField("join_session_code", text: $code)
                    .keyboardType(.numberPad)
                    .padding()
                    .foregroundColor(Stylesheet.color(.primary))
                    .background(Stylesheet.color(.background))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Stylesheet.color(.primary), lineWidth: 1.5))
                    .padding(.bottom)

                if store.state.user == nil {
                    AppleButton()
                        .opacity(shouldDisableButton ? 0.4 : 1.0)
                        .disabled(shouldDisableButton)
                    GoogleButton()
                        .opacity(shouldDisableButton ? 0.4 : 1.0)
                        .disabled(shouldDisableButton)
                } else {
                    Button(action: {
                        self.store.dispatch(action: .session(.start(code: self.code, user: self.store.state.user!)))
                    }) {
                        HStack {
                            Text("join_session_enter")
                            if store.state.isRequestingSession {
                                ActivityIndicator(
                                    isAnimating: self.$activityIndicatorIsAnimating,
                                    style: .medium,
                                    color: Stylesheet.color(.background)
                                )
                            }
                        }.frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Stylesheet.color(.onPrimary))
                        .background(Stylesheet.color(.primary))
                        .cornerRadius(8.0)
                    }
                }
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
