import SwiftUI

struct JoinSessionView: View {

    @EnvironmentObject var store: AppStore
    @State private var code: String = ""
    @State private var activityAnimatorIsAnimating = true
    private var shouldDisableButton: Bool {
        code.isEmpty
    }
    private var buttonForegroundColor: Color {
        shouldDisableButton ? Stylesheet.color(.primary10) : Stylesheet.color(.primary)
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
                        .fontWeight(.regular)
                        .font(Stylesheet.font(.m))
                        .foregroundColor(Stylesheet.color(.error))
                        .lineLimit(.none)
                        .padding(.top)
                }

                TextField("join_session_code", text: $code)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Stylesheet.color(.background))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8.0)
                            .stroke(Stylesheet.color(.primary), lineWidth: 1.5))
                    .padding(.bottom)
                    .disabled(store.state.isRequestingSession)

                GoogleButton()
                    .disabled(shouldDisableButton)
                Spacer()
            }
            .padding()
            .background(Stylesheet.color(.background))
            .navigationBarTitle("app_name", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct JoinSessionView_Previews: PreviewProvider {
    static var previews: some View {
        JoinSessionView()
    }
}
